import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/extensions.dart';
import 'package:rssify/core/services/deeplink_service.dart';
import 'package:rssify/core/services/refresh_service.dart';
import 'package:rssify/core/services/updater_service.dart';
import 'package:rssify/core/sizes.dart';
import 'package:rssify/core/widgets/dialogs/progress_dialog.dart';
import 'package:rssify/features/feed/presentation/feed_add_widget.dart';
import 'package:rssify/features/feed/presentation/feed_list_widget.dart';
import 'package:rssify/features/feed_item_list/presentation/controller/feed_item_list_notifier.dart';
import 'package:rssify/features/sidebar/presentation/controller/sidebar_notifier.dart';
import 'package:rssify/features/sidebar/presentation/widget/sidebar_list_tile_text_widget.dart';
import 'package:stockholm/stockholm.dart';

class SidebarWidget extends ConsumerStatefulWidget {
  const SidebarWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends ConsumerState<SidebarWidget> {
  int? _selectedIndex;
  int? _selectedFeed;

  @override
  void initState() {
    super.initState();
    final linkService = DeepLinkService(
      onFeedUrlReceived: (feedUrl) async {
        await _showAddFeedDialog(context, feedUrl);
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      linkService.checkForInitialUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final state = ref.watch(sideBarNotifierProvider);

        return StockholmSideBar(
          padding: const .only(top: Sizes.p32),
          footer: Padding(
            padding: const EdgeInsets.all(Sizes.p4),
            child: Row(
              spacing: Sizes.p4,
              children: [
                Tooltip(
                  message: context.l10n.checkForUpdates,
                  child: StockholmToolbarButton(
                    icon: CupertinoIcons.cloud_download,
                    onPressed: _checkForUpdates,
                  ),
                ),
                const Spacer(),
                Tooltip(
                  message: context.l10n.refreshFeed,
                  child: StockholmToolbarButton(
                    icon: CupertinoIcons.refresh,
                    onPressed: () => _refresh(ref),
                  ),
                ),
                Tooltip(
                  message: context.l10n.addNewFeed,
                  child: StockholmToolbarButton(
                    icon: CupertinoIcons.add,
                    onPressed: () => _showAddFeedDialog(context),
                  ),
                ),
              ],
            ),
          ),
          children: [
            GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onSecondaryTapUp: (details) {
                _showUnreadTooltip(details.globalPosition);
              },
              child: StockholmListTile(
                leading: const Icon(CupertinoIcons.today),
                selected: _selectedIndex == 0,
                child: SidebarListTileTextWidget(
                  text: context.l10n.unread,
                  count: state.feedItemUnreadCount,
                ),
                onPressed: () {
                  _getAllFeedsUnread(ref);
                  _setSelectedIndex(0);
                },
              ),
            ),
            StockholmListTile(
              leading: const Icon(CupertinoIcons.star),
              selected: _selectedIndex == 1,
              onPressed: () {
                _getAllFeedsStarred(ref);
                _setSelectedIndex(1);
              },
              child: SidebarListTileTextWidget(
                text: context.l10n.starred,
                count: state.feedItemStarredCount,
              ),
            ),
            StockholmListTile(
              leading: const Icon(CupertinoIcons.list_bullet),
              selected: _selectedIndex == 2,
              onPressed: () {
                _getAllFeedItems(ref);
                _setSelectedIndex(2);
              },
              child: SidebarListTileTextWidget(
                text: context.l10n.all,
                count: state.feedItemCount,
              ),
            ),
            const Divider(),
            FeedListWidget(
              selectedFeed: _selectedFeed,
              onPressed: (feedId) => _filterByFeedID(feedId, ref),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getAllFeedItems(WidgetRef ref) async {
    await ref.read(feedItemListNotifierProvider.notifier).getAllFeedItems();
  }

  Future<void> _refresh(WidgetRef ref) async {
    await showProgressDialog(context, () async {
      await ref.read(refreshServiceProvider).refresh();
      await ref
          .read(feedItemListNotifierProvider.notifier)
          .getAllUnreadFeedItems();
    });
    setState(() {
      _selectedIndex = 0;
    });
  }

  Future<void> _showAddFeedDialog(
    BuildContext context, [
    String? initialUrl,
  ]) async {
    final feedAdded = await showAdaptiveDialog<bool?>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return FeedAddWidget(initialUrl: initialUrl);
      },
    );
    if (feedAdded ?? false) {
      await _refresh(ref);
    }
  }

  Future<void> _getAllFeedsStarred(WidgetRef ref) async {
    await ref
        .read(feedItemListNotifierProvider.notifier)
        .getAllFeedItemsStarred();
  }

  Future<void> _getAllFeedsUnread(WidgetRef ref) async {
    await ref
        .read(feedItemListNotifierProvider.notifier)
        .getAllUnreadFeedItems();
  }

  void _setSelectedIndex(int? index) {
    setState(() {
      _selectedIndex = index;
      _selectedFeed = null;
    });
  }

  Future<void> _showUnreadTooltip(Offset globalPosition) async {
    await showStockholmMenu(
      context: context,
      preferredAnchorPoint: globalPosition,
      menu: StockholmMenu(
        items: [
          StockholmMenuItem(
            child: Text(context.l10n.markAllAsReadTooltip),
            onSelected: () async {
              await ref
                  .read(feedItemListNotifierProvider.notifier)
                  .markAllFeedItemsAsRead();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _checkForUpdates() async {
    await ref.read(updaterServiceProvider).triggerUpdateCheck();
  }

  void _filterByFeedID(int id, WidgetRef ref) {
    ref
        .read(feedItemListNotifierProvider.notifier)
        .getAllFeedItemsFilteredById(id);
    setState(() {
      _selectedFeed = id;
      _selectedIndex = null;
    });
  }
}
