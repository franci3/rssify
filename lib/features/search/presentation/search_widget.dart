import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/sizes.dart';
import 'package:rssify/features/feed_item_list/presentation/controller/feed_item_list_notifier.dart';
import 'package:stockholm/stockholm.dart';

class SearchWidget extends ConsumerWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.p4,
        horizontal: Sizes.p8,
      ).add(const EdgeInsetsGeometry.only(bottom: Sizes.p2)),
      child: StockholmTextField(
        onSubmitted: (value) {
          ref
              .read(feedItemListNotifierProvider.notifier)
              .searchAllFeedItems(value);
        },
        placeholder: 'Search',
      ),
    );
  }
}
