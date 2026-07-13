import 'package:stockholm/stockholm.dart';

class GlobalTheme {
  static final globalAppTheme = StockholmThemeData.dark(
    accentColor: StockholmColors.fromBrightness(.dark, .macOS).blue,
    platform: .macOS,
  );
}
