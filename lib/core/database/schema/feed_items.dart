import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/feeds.dart';

@DataClassName('FeedItem')
class FeedItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get link => text()();
  DateTimeColumn get published => dateTime()();
  TextColumn get author => text()();
  IntColumn get feedId => integer().references(Feeds, #id)();
  TextColumn get hash => text().unique()();
  DateTimeColumn get fetchedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isMarked => boolean().clientDefault(() => false)();
  BoolColumn get wasRead => boolean().clientDefault(() => false)();
}

extension CustomFeedItemCreator on FeedItemsCompanion {
  static FeedItemsCompanion createWithHash({
    required String title,
    required String link,
    required String description,
    required DateTime published,
    required String author,
    required int feedId,
  }) {
    return FeedItemsCompanion.insert(
      title: title,
      link: link,
      description: description,
      published: published,
      author: author,
      feedId: feedId,
      hash: md5.convert(utf8.encode('$link$title')).toString(),
    );
  }
}
