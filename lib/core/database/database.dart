import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rssify/core/constants.dart';
import 'package:rssify/core/database/daos/feed_items_dao.dart';
import 'package:rssify/core/database/daos/feeds_dao.dart';
import 'package:rssify/core/database/daos/preferences_dao.dart';
import 'package:rssify/core/database/schema/feed_items.dart';
import 'package:rssify/core/database/schema/feeds.dart';
import 'package:rssify/core/database/schema/preferences.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [FeedItems, Feeds, Preferences],
  daos: [FeedItemsDao, FeedsDao, PreferencesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {},
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() {
    final name = kDebugMode
        ? '${Constants.databaseName}_debug'
        : Constants.databaseName;
    return driftDatabase(
      name: name,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

final databaseProvider = Provider((_) => AppDatabase());
