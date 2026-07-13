import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/preferences.dart';

class PreferencesService {
  final AppDatabase _appDatabase;

  const PreferencesService({required this._appDatabase});

  Future<Preference?> getUserPreference() async {
    return _appDatabase.preferencesDao.getUserPreference();
  }

  Future<int> setUserPreference({
    required double fontSize,
    required FeedItemFonts fontFamily,
  }) async {
    return _appDatabase.preferencesDao.setUserPreference(
      fontSize: fontSize.toInt(),
      fontFamily: fontFamily,
    );
  }
}

final preferencesServiceProvider = Provider<PreferencesService>(
  (ref) => PreferencesService(appDatabase: ref.watch(databaseProvider)),
);
