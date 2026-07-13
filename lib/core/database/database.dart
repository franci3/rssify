import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
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

  static QueryExecutor _openConnection() {
    /*if (kDebugMode) {
      return NativeDatabase.memory();
    }*/

    return driftDatabase(
      name: Constants.databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

final databaseProvider = Provider((_) => AppDatabase());
