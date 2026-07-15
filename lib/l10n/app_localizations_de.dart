// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get all => 'Alle';

  @override
  String get starred => 'Markiert';

  @override
  String get unread => 'Ungelesen';

  @override
  String get checkForUpdates => 'Nach Updates suchen';

  @override
  String get refreshFeed => 'Feed aktualisieren';

  @override
  String get addNewFeed => 'Neuen Feed hinzufügen';

  @override
  String get search => 'Suchen';

  @override
  String get emptyRSSFeedItem =>
      'Füge einen RSS-Feed hinzu oder klicke auf ein Element';

  @override
  String get switchFontFamilyTooltip => 'Schriftfamilie wechseln';

  @override
  String get switchFontSizeTooltip => 'Schriftgröße wechseln';

  @override
  String get shareTooltip => 'Teilen';

  @override
  String get starTooltip => 'Artikel markieren';

  @override
  String get summarizeTooltip => 'Artikel zusammenfassen';

  @override
  String get openInBrowserTooltip => 'Zur Website gehen';

  @override
  String get deleteFeedDialogTitle => 'Feed löschen';

  @override
  String get delete => 'Löschen';

  @override
  String deleteFeedDialogContent(String feedName) {
    return 'Bist du sicher, dass du $feedName löschen möchtest?';
  }

  @override
  String get add => 'Hinzufügen';

  @override
  String get addFeedDialogTitle => 'Feed hinzufügen';

  @override
  String get link => 'Link';

  @override
  String get name => 'Name';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get addFeedRequired => 'URL und Name erforderlich.';

  @override
  String get markAllAsReadTooltip => 'Alle als gelesen markieren';

  @override
  String get errorDialogTitle => 'Etwas ist schiefgelaufen';

  @override
  String get dismiss => 'Schließen';

  @override
  String get addFeedExceptionContent =>
      'Feed konnte nicht hinzugefügt werden, überprüfe deine Eingaben!';

  @override
  String get summaryTitle => 'Zusammenfassung (KI-generiert)';

  @override
  String get summarizeException =>
      'Es gab ein Problem beim Zusammenfassen dieses Artikels';
}
