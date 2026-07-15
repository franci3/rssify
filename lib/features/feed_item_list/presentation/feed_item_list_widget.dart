import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/sizes.dart';
import 'package:rssify/core/util/datetime_formats.dart';
import 'package:rssify/core/widgets/async_value/async_value_state_widget.dart';
import 'package:rssify/features/feed_item_list/presentation/controller/feed_item_list_notifier.dart';
import 'package:rssify/features/search/presentation/search_widget.dart';
import 'package:stockholm/stockholm.dart';

class FeedItemListWidget extends ConsumerStatefulWidget {
  const FeedItemListWidget({super.key, required this.onSelected});

  final void Function(FeedItem) onSelected;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeedItemListWidgetState();
}

class _FeedItemListWidgetState extends ConsumerState<FeedItemListWidget> {
  FeedItem? selectedFeedItem;

  @override
  Widget build(BuildContext context) {
    return StockholmSideBar(
      padding: const EdgeInsetsGeometry.only(top: Sizes.p4),
      footer: const SearchWidget(),
      children: [
        Builder(
          builder: (context) {
            final state = ref.watch(feedItemListNotifierProvider);
            return AsyncValueStateWidget(
              asyncValueState: state,
              onData: (data) {
                return Column(
                  spacing: Sizes.p4,
                  children: data.map((feedItem) {
                    final bool isUnread = !feedItem.wasRead;
                    return StockholmListTile(
                      selected: selectedFeedItem?.id == feedItem.id,
                      onPressed: () => selectFeedItem(feedItem),
                      leading: isUnread
                          ? const ColoredBox(
                              color: Colors.blueAccent,
                              child: SizedBox(width: Sizes.p2),
                            )
                          : const SizedBox.shrink(),
                      child: Column(
                        crossAxisAlignment: .stretch,
                        spacing: Sizes.p4,
                        children: [
                          Row(
                            crossAxisAlignment: .start,
                            spacing: Sizes.p4,
                            children: [
                              Expanded(
                                child: Text(
                                  feedItem.title,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: isUnread ? .bold : .normal,
                                        fontStyle: isUnread ? .italic : .normal,
                                      ),
                                ),
                              ),
                              feedItem.isMarked
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: Sizes.p2),
                                      child: Icon(
                                        CupertinoIcons.star_fill,
                                        color: Colors.amber,
                                        size: Sizes.p8,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  feedItem.author,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  overflow: .ellipsis,
                                ),
                              ),
                              Text(
                                getFormattedDateTimeSmall(feedItem.published),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void selectFeedItem(FeedItem item) {
    setState(() {
      selectedFeedItem = item;
    });
    widget.onSelected(item);
  }
}
