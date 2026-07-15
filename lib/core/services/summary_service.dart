import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rssify/core/constants.dart';

class SummaryService {
  final Logger _logger = Logger('SummaryService');

  static const MethodChannel _channel = MethodChannel(
    Constants.updaterMethodChannel,
  );

  Future<String?> summarize(String selectedText) async {
    try {
      final String? summary = await _channel.invokeMethod<String>(
        Constants.summaryMethodChannelMethod,
        {'text': selectedText},
      );
      return summary;
    } on PlatformException catch (e, st) {
      _logger.severe('Summary error: ${e.message}', e, st);
      return null;
    }
  }
}

final summaryServiceProvider = Provider<SummaryService>(
  (ref) => SummaryService(),
);
