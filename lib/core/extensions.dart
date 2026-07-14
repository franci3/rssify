import 'package:flutter/cupertino.dart';
import 'package:rssify/l10n/app_localizations.dart';

extension XBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
