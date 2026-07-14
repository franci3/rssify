// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get all => 'All';

  @override
  String get starred => 'Starred';

  @override
  String get unread => 'Unread';

  @override
  String get checkForUpdates => 'Check for updates';

  @override
  String get refreshFeed => 'Refresh feed';

  @override
  String get addNewFeed => 'Add new feed';

  @override
  String get search => 'Search';

  @override
  String get emptyRSSFeedItem => 'Add an RSS Feed or click on an Item';

  @override
  String get switchFontFamilyTooltip => 'Switch font-family';

  @override
  String get switchFontSizeTooltip => 'Switch font-size';

  @override
  String get shareTooltip => 'Share';

  @override
  String get starTooltip => 'Star this article';

  @override
  String get summarizeTooltip => 'Summarize article (Coming soon)';

  @override
  String get openInBrowserTooltip => 'Go to website';

  @override
  String get deleteFeedDialogTitle => 'Delete feed';

  @override
  String get delete => 'Delete';

  @override
  String deleteFeedDialogContent(String feedName) {
    return 'Are you sure you want to delete $feedName?';
  }

  @override
  String get add => 'Add';

  @override
  String get addFeedDialogTitle => 'Add feed';

  @override
  String get link => 'Link';

  @override
  String get name => 'Name';

  @override
  String get cancel => 'Cancel';

  @override
  String get addFeedRequired => 'URL and Name required.';
}
