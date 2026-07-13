import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/features/feed_item_list/data/feed_item_repository_implementation.dart';
import 'package:rssify/features/feed_item_list/domain/feed_item_repository.dart';

class FeedItemListNotifier extends AsyncNotifier<List<FeedItem>> {
  late final FeedItemRepository _feedItemRepository;
  final Logger _logger = Logger('FeedItemListNotifier');

  @override
  FutureOr<List<FeedItem>> build() {
    _feedItemRepository = ref.watch(feedItemRepositoryProvider);
    return _feedItemRepository.getFeedItems();
  }

  Future<void> markFeedItemAsRead(FeedItem item) async {
    try {
      await _feedItemRepository.markFeedItemAsRead(feedItemId: item.id);

      final currentItems = state.value;
      if (currentItems != null) {
        state = AsyncData(
          currentItems.map((e) {
            return e.id == item.id ? e.copyWith(wasRead: true) : e;
          }).toList(),
        );
      }
      _logger.info('FeedItem: ${item.id} marked as read');
    } on Exception catch (e, st) {
      _logger.severe('Could not mark item as read', e, st);
    }
  }

  Future<void> getAllUnreadFeedItems() async {
    final items = await _feedItemRepository.getFeedItems(onlyUnread: true);
    state = AsyncValue.data(items);
  }

  Future<void> searchAllFeedItems(String query) async {
    final items = await _feedItemRepository.getFeedItems(filterQuery: query);
    state = AsyncValue.data(items);
  }

  Future<void> getAllFeedItems() async {
    final items = await _feedItemRepository.getFeedItems();
    state = AsyncValue.data(items);
  }

  Future<void> getAllFeedItemsFilteredById(int feedId) async {
    final items = await _feedItemRepository.getFeedItems(filterFeedId: feedId);
    state = AsyncValue.data(items);
  }

  Future<void> getAllFeedItemsStarred() async {
    final items = await _feedItemRepository.getFeedItems(onlyStarred: true);
    state = AsyncValue.data(items);
  }

  Future<void> markFeedItemAsStarred(FeedItem item) async {
    try {
      await _feedItemRepository.markFeedItemAsStarred(
        feedItemId: item.id,
        starredState: !item.isMarked,
      );

      final currentItems = state.value;
      if (currentItems != null) {
        state = AsyncData(
          currentItems.map((e) {
            return e.id == item.id ? e.copyWith(isMarked: !item.isMarked) : e;
          }).toList(),
        );
      }
      _logger.info('FeedItem: ${item.id} marked as starred: ${!item.isMarked}');
    } on Exception catch (e, st) {
      _logger.severe('Could not mark item as read', e, st);
    }
  }
}

final feedItemListNotifierProvider =
    AsyncNotifierProvider.autoDispose<FeedItemListNotifier, List<FeedItem>>(
      () => FeedItemListNotifier(),
    );
