import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:rssify/core/constants.dart';

class DeepLinkService {
  final Logger _logger = Logger('DeepLinkService');
  static const _platform = MethodChannel(Constants.updaterMethodChannel);

  final void Function(String) onFeedUrlReceived;

  DeepLinkService({required this.onFeedUrlReceived}) {
    _platform.setMethodCallHandler((call) async {
      if (call.method == Constants.onDeepLinkMethodsChannelMethod) {
        final String? url = call.arguments as String?;
        if (url != null) {
          _processIncomingUrl(url);
        }
      }
    });
  }

  Future<void> checkForInitialUrl() async {
    try {
      final String? initialUrl = await _platform.invokeMethod<String>(
        Constants.getInitialUrlMethodsChannelMethod,
      );
      if (initialUrl != null) {
        _processIncomingUrl(initialUrl);
      }
    } on PlatformException catch (e, st) {
      _logger.severe('Failed to check initial link', e, st);
    }
  }

  void _processIncomingUrl(String fullUrl) {
    String cleanUrl = fullUrl;

    if (cleanUrl.startsWith('feed://')) {
      cleanUrl = cleanUrl.replaceFirst('feed://', 'https://');
    }

    onFeedUrlReceived(cleanUrl);
  }
}
