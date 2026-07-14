import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/extensions.dart';
import 'package:rssify/core/widgets/async_value/async_value_state_widget.dart';
import 'package:rssify/features/feed/presentation/controller/feed_notifier.dart';
import 'package:stockholm/stockholm.dart';

class FeedListWidget extends ConsumerWidget {
  const FeedListWidget({super.key, this.selectedFeed, required this.onPressed});
  final int? selectedFeed;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (context) {
        final state = ref.watch(feedNotifierProvider);

        return AsyncValueStateWidget<List<Feed>>(
          asyncValueState: state,
          onData: (data) {
            return Column(
              crossAxisAlignment: .start,
              children: data
                  .map(
                    (feed) => StockholmListTile(
                      selected: selectedFeed == feed.id,
                      onPressed: () => onPressed(feed.id),
                      onDelete: () => _deleteFeed(feed, ref, context),
                      child: Text(feed.name),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }

  void _deleteFeed(Feed feed, WidgetRef ref, BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return StockholmAlertDialog(
          title: Text(context.l10n.deleteFeedDialogTitle),
          buttonTitle: Text(context.l10n.delete),
          contents: Text(context.l10n.deleteFeedDialogContent(feed.name)),
          onClosed: () async {
            await ref
                .read(feedNotifierProvider.notifier)
                .deleteFeed(feedId: feed.id);
          },
        );
      },
    );
  }
}
