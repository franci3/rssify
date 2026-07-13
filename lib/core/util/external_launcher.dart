import 'package:logging/logging.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void goToWebsite(String url) {
  try {
    launchUrl(Uri.parse(url));
  } on Exception catch (e, st) {
    Logger('External Launcher').severe('Could not launch: $url', e, st);
  }
}

void shareUrl(String url) {
  try {
    SharePlus.instance.share(ShareParams(text: 'Checkout this article: $url'));
  } on Exception catch (e, st) {
    Logger('External Share').severe('Could not share: $url', e, st);
  }
}
