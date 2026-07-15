import 'package:rssify/core/database/database.dart';

abstract class FeedItemRepository {
  Future<List<FeedItem>> getFeedItems({
    int? filterFeedId,
    bool onlyUnread = false,
    bool onlyStarred = false,
    bool onlyToday = false,
    String? filterQuery,
  });
  Future<void> markFeedItemAsRead({required int feedItemId});

  Future<void> markFeedItemAsStarred({
    required int feedItemId,
    required bool starredState,
  });

  Future<void> deleteFeedItemsByFeedId({required int feedId});
  Future<void> markAllUnreadAsRead();
}
