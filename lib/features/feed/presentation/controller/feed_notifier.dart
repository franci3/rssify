import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/features/feed/data/feed_repository_implementation.dart';
import 'package:rssify/features/feed/domain/feed_repository.dart';
import 'package:rssify/features/feed_item_list/data/feed_item_repository_implementation.dart';
import 'package:rssify/features/feed_item_list/domain/feed_item_repository.dart';

class FeedNotifier extends StreamNotifier<List<Feed>> {
  late final FeedRepository _feedRepository;
  late final FeedItemRepository _feedItemRepository;

  Future<void> addFeed({required String name, required String url}) async {
    await _feedRepository.addFeed(name: name, url: url);
  }

  Future<void> getFeed() async {
    state = AsyncValue.data(await _feedRepository.getFeed());
  }

  Future<void> deleteFeed({required int feedId}) async {
    await _feedRepository.deleteFeed(feedId: feedId);
    unawaited(_deleteFeedItems(feedId: feedId));
    state.requireValue.removeWhere((feed) => feed.id == feedId);
  }

  @override
  Stream<List<Feed>> build() {
    _feedRepository = ref.watch(feedRepositoryProvider);
    _feedItemRepository = ref.read(feedItemRepositoryProvider);
    return _feedRepository.watchFeed();
  }

  Future<void> _deleteFeedItems({required int feedId}) async {
    await _feedItemRepository.deleteFeedItemsByFeedId(feedId: feedId);
    await _feedItemRepository.getFeedItems();
  }
}

final feedNotifierProvider =
    StreamNotifierProvider.autoDispose<FeedNotifier, List<Feed>>(
      () => FeedNotifier(),
    );
