import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/services/parser_service.dart';
import 'package:rssify/features/feed/domain/feed_repository.dart';

class FeedRepositoryImplementation implements FeedRepository {
  final AppDatabase _database;
  final ParserService _parserService;

  const FeedRepositoryImplementation({
    required this._database,
    required this._parserService,
  });

  @override
  Future<int> addFeed({required String name, required String url}) async {
    final feedType = await _parserService.getFeedTypeFromUrl(url);
    return _database.feedsDao.addFeed(name: name, url: url, feedType: feedType);
  }

  @override
  Future<int> deleteFeed({required int feedId}) {
    return _database.feedsDao.deleteFeed(feedId);
  }

  @override
  Stream<List<Feed>> watchFeed() {
    return _database.feedsDao.streamFeeds();
  }

  @override
  Future<List<Feed>> getFeed() {
    return _database.feedsDao.getFeeds();
  }
}

final feedRepositoryProvider = Provider<FeedRepository>(
  (ref) => FeedRepositoryImplementation(
    database: ref.watch(databaseProvider),
    parserService: ref.watch(parserServiceProvider),
  ),
);
