import 'package:drift/drift.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/feeds.dart';

part 'feeds_dao.g.dart';

@DriftAccessor(tables: [Feeds])
class FeedsDao extends DatabaseAccessor<AppDatabase> with _$FeedsDaoMixin {
  FeedsDao(super.db);

  Future<List<Feed>> getFeeds() {
    final query = select(feeds);
    query.orderBy([(t) => OrderingTerm(expression: t.fetchedAt)]);
    return query.get();
  }

  Future<int> addFeed({
    required String name,
    required String url,
    required FeedType feedType,
  }) {
    return into(feeds).insertOnConflictUpdate(
      FeedsCompanion.insert(name: name, link: url, feedType: feedType),
    );
  }

  Future<int> deleteFeed(int feedId) async {
    return (delete(feeds)..where((t) => t.id.equals(feedId))).go();
  }

  Stream<List<Feed>> streamFeeds() {
    final query = select(feeds);
    query.orderBy([(t) => OrderingTerm(expression: t.fetchedAt)]);
    return query.watch();
  }
}
