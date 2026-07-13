import 'package:drift/drift.dart';

enum FeedItemFonts {
  georgina('Georgia'),
  monaco('Monaco'),
  charter('Charter'),
  palatino('Palatino'),
  avenirNext('Avenir Next'),
  helveticaNeue('Helvetica Neue');

  final String value;

  const FeedItemFonts(this.value);
}

@DataClassName('Preference')
class Preferences extends Table {
  IntColumn get id => integer().clientDefault(() => 1)();
  TextColumn get fontFamily => textEnum<FeedItemFonts>()();
  IntColumn get fontSize => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
