import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rssify/core/constants.dart';

class UpdaterService {
  final Logger _logger = Logger('Updater Service');
  static const _platform = MethodChannel(Constants.updaterMethodChannel);

  Future<void> triggerUpdateCheck() async {
    try {
      await _platform.invokeMethod(Constants.updaterMethodChannelMethod);
    } on PlatformException catch (e, st) {
      _logger.severe('Failed to check for updates', e, st);
    }
  }
}

final updaterServiceProvider = Provider<UpdaterService>(
  (ref) => UpdaterService(),
);
