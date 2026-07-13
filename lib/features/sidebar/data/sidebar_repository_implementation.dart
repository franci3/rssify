import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/features/sidebar/domain/sidebar_repository.dart';

class SidebarRepositoryImplementation implements SidebarRepository {
  final AppDatabase _database;
  const SidebarRepositoryImplementation({required this._database});

  @override
  Stream<int> streamFeedCount() {
    return _database.feedItemsDao.streamFeedsCount();
  }

  @override
  Stream<int> streamStarredFeedCount() {
    return _database.feedItemsDao.streamStarredFeedsCount();
  }

  @override
  Stream<int> streamUnreadFeedCount() {
    return _database.feedItemsDao.streamUnreadFeedsCount();
  }
}

final sidebarRepositoryProvider = Provider<SidebarRepository>(
  (ref) =>
      SidebarRepositoryImplementation(database: ref.watch(databaseProvider)),
);
