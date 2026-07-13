import 'package:drift/drift.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/preferences.dart';

part 'preferences_dao.g.dart';

@DriftAccessor(tables: [Preferences])
class PreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$PreferencesDaoMixin {
  PreferencesDao(super.db);

  Future<Preference?> getUserPreference() async {
    final query = select(preferences);
    return query.getSingleOrNull();
  }

  Future<int> setUserPreference({
    required int fontSize,
    required FeedItemFonts fontFamily,
  }) async {
    return into(preferences).insertOnConflictUpdate(
      PreferencesCompanion.insert(fontSize: fontSize, fontFamily: fontFamily),
    );
  }
}
