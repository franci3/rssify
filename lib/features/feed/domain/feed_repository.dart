import 'package:rssify/core/database/database.dart';

abstract class FeedRepository {
  Stream<List<Feed>> watchFeed();
  Future<List<Feed>> getFeed();
  Future<int> deleteFeed({required int feedId});
  Future<int> addFeed({required String name, required String url});
}
