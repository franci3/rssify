import 'package:drift/drift.dart';

enum FeedType { rssV1, rssV2, atom }

@DataClassName('Feed')
class Feeds extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get link => text()();
  TextColumn get feedType => textEnum<FeedType>()();
  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();
}
