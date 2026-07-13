import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/preferences.dart';
import 'package:rssify/core/services/preferences_service.dart';

class FeedPreferencesNotifier extends AsyncNotifier<Preference?> {
  late final PreferencesService _preferencesService;
  @override
  FutureOr<Preference?> build() async {
    _preferencesService = ref.watch(preferencesServiceProvider);
    return _preferencesService.getUserPreference();
  }

  Future<void> setUserPreferences({
    required double fontSize,
    required FeedItemFonts fontFamily,
  }) async {
    await _preferencesService.setUserPreference(
      fontSize: fontSize,
      fontFamily: fontFamily,
    );
    final preference = await _preferencesService.getUserPreference();
    state = AsyncValue.data(preference);
  }
}

final feedPreferenceNotifierProvider =
    AsyncNotifierProvider<FeedPreferencesNotifier, Preference?>(
      () => FeedPreferencesNotifier(),
    );
