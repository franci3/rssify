import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/services/parser_service.dart';

class RefreshService {
  final AppDatabase _appDatabase;
  final ParserService _parserService;

  const RefreshService({
    required this._appDatabase,
    required this._parserService,
  });

  Future<void> refresh() async {
    // Get all feeds
    final feeds = await _getAllFeeds();
    // Get all updates on rss/ atom feeds in an isolate
    // Parse feed items to FeedItemsCompanion
    final items = await _updateFeedItems(feeds);
    // Batch insert into Database
    await _appDatabase.feedItemsDao.batchAddFeedItems(items);
  }

  Future<List<Feed>> _getAllFeeds() async {
    return _appDatabase.feedsDao.getFeeds();
  }

  Future<List<FeedItemsCompanion>> _updateFeedItems(List<Feed> feeds) async {
    final List<Future<List<FeedItemsCompanion>>> feedItemsRefreshFutures =
        List.empty(growable: true);
    for (final feed in feeds) {
      feedItemsRefreshFutures.add(_parserService.parseFeedItemsFromFeed(feed));
    }
    final feedResponses = await Future.wait(feedItemsRefreshFutures);
    return feedResponses.expand((i) => i).toList();
  }
}

final refreshServiceProvider = Provider<RefreshService>(
  (ref) => RefreshService(
    appDatabase: ref.watch(databaseProvider),
    parserService: ref.watch(parserServiceProvider),
  ),
);
