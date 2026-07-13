import 'package:drift/drift.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/feed_items.dart';

part 'feed_items_dao.g.dart';

@DriftAccessor(tables: [FeedItems])
class FeedItemsDao extends DatabaseAccessor<AppDatabase>
    with _$FeedItemsDaoMixin {
  FeedItemsDao(super.db);

  Future<List<FeedItem>> getFeedItems({
    int limit = 100,
    bool? unread,
    int? feedId,
    bool? starred,
    bool? onlyToday,
    String? titleFilter,
  }) {
    final query = select(feedItems)..limit(limit);
    if (unread ?? false) {
      query.where((t) => t.wasRead.equals(false));
    }
    if (starred ?? false) {
      query.where((t) => t.isMarked.equals(true));
    }
    if (feedId != null) {
      query.where((t) => t.feedId.equals(feedId));
    }
    if (onlyToday ?? false) {
      final now = DateTime.now();
      final startOfToday = DateTime(now.year, now.month, now.day);
      query.where((t) => t.published.isBiggerOrEqualValue(startOfToday));
    }
    if (titleFilter != null && titleFilter.isNotEmpty) {
      query.where((t) => t.title.like('%$titleFilter%'));
    }
    query.orderBy([
      (u) => OrderingTerm(expression: u.published, mode: OrderingMode.desc),
      (u) => OrderingTerm(expression: u.fetchedAt, mode: OrderingMode.desc),
    ]);
    return query.get();
  }

  Future<void> batchAddFeedItems(List<FeedItemsCompanion> batchedItems) {
    return batch((batch) {
      batch.insertAll(feedItems, batchedItems, mode: InsertMode.insertOrIgnore);
    });
  }

  Future<int> markItemAsRead(int feedItemId) async {
    return await (update(feedItems)..where((t) => t.id.equals(feedItemId)))
        .write(const FeedItemsCompanion(wasRead: Value(true)));
  }

  Future<int> markItemAsStarred(int feedItemId, bool starredState) async {
    return await (update(feedItems)..where((t) => t.id.equals(feedItemId)))
        .write(FeedItemsCompanion(isMarked: Value(starredState)));
  }

  Future<int> deleteFeedItemsByFeedId({required int feedId}) async {
    return await (delete(
      feedItems,
    )..where((item) => item.feedId.equals(feedId))).go();
  }

  Stream<int> streamFeedsCount() {
    return customSelect(
      'SELECT COUNT(*) AS c FROM feed_items',
      readsFrom: {feedItems},
    ).map((row) => row.read<int>('c')).watchSingle();
  }

  Stream<int> streamUnreadFeedsCount() {
    return customSelect(
      'SELECT COUNT(*) AS c FROM feed_items WHERE was_read = ?',
      variables: [Variable.withInt(0)],
      readsFrom: {feedItems},
    ).map((row) => row.read<int>('c')).watchSingle();
  }

  Stream<int> streamStarredFeedsCount() {
    return customSelect(
      'SELECT COUNT(*) AS c FROM feed_items WHERE is_marked = ?',
      variables: [Variable.withInt(1)],
      readsFrom: {feedItems},
    ).map((row) => row.read<int>('c')).watchSingle();
  }
}
