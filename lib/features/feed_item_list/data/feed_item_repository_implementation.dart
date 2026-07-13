import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/features/feed_item_list/domain/feed_item_repository.dart';

class FeedItemRepositoryImplementation implements FeedItemRepository {
  final AppDatabase _database;

  const FeedItemRepositoryImplementation({required this._database});

  @override
  Future<List<FeedItem>> getFeedItems({
    int? filterFeedId,
    bool onlyUnread = false,
    bool onlyStarred = false,
    bool onlyToday = false,
    String? filterQuery,
  }) async {
    return _database.feedItemsDao.getFeedItems(
      feedId: filterFeedId,
      unread: onlyUnread,
      starred: onlyStarred,
      onlyToday: onlyToday,
      titleFilter: filterQuery,
    );
  }

  @override
  Future<int> markFeedItemAsRead({required int feedItemId}) async {
    return await _database.feedItemsDao.markItemAsRead(feedItemId);
  }

  @override
  Future<int> markFeedItemAsStarred({
    required int feedItemId,
    required bool starredState,
  }) async {
    return await _database.feedItemsDao.markItemAsStarred(
      feedItemId,
      starredState,
    );
  }

  @override
  Future<int> deleteFeedItemsByFeedId({required int feedId}) async {
    return await _database.feedItemsDao.deleteFeedItemsByFeedId(feedId: feedId);
  }
}

final feedItemRepositoryProvider = Provider<FeedItemRepository>(
  (ref) =>
      FeedItemRepositoryImplementation(database: ref.watch(databaseProvider)),
);
