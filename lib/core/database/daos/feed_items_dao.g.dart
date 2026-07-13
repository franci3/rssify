// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_items_dao.dart';

// ignore_for_file: type=lint
mixin _$FeedItemsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FeedsTable get feeds => attachedDatabase.feeds;
  $FeedItemsTable get feedItems => attachedDatabase.feedItems;
  FeedItemsDaoManager get managers => FeedItemsDaoManager(this);
}

class FeedItemsDaoManager {
  final _$FeedItemsDaoMixin _db;
  FeedItemsDaoManager(this._db);
  $$FeedsTableTableManager get feeds =>
      $$FeedsTableTableManager(_db.attachedDatabase, _db.feeds);
  $$FeedItemsTableTableManager get feedItems =>
      $$FeedItemsTableTableManager(_db.attachedDatabase, _db.feedItems);
}
