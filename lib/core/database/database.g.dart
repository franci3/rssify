// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FeedsTable extends Feeds with TableInfo<$FeedsTable, Feed> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FeedType, String> feedType =
      GeneratedColumn<String>(
        'feed_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedType>($FeedsTable.$converterfeedType);
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, link, feedType, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feeds';
  @override
  VerificationContext validateIntegrity(
    Insertable<Feed> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feed map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feed(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      )!,
      feedType: $FeedsTable.$converterfeedType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}feed_type'],
        )!,
      ),
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $FeedsTable createAlias(String alias) {
    return $FeedsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FeedType, String, String> $converterfeedType =
      const EnumNameConverter<FeedType>(FeedType.values);
}

class Feed extends DataClass implements Insertable<Feed> {
  final int id;
  final String name;
  final String link;
  final FeedType feedType;
  final DateTime fetchedAt;
  const Feed({
    required this.id,
    required this.name,
    required this.link,
    required this.feedType,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['link'] = Variable<String>(link);
    {
      map['feed_type'] = Variable<String>(
        $FeedsTable.$converterfeedType.toSql(feedType),
      );
    }
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  FeedsCompanion toCompanion(bool nullToAbsent) {
    return FeedsCompanion(
      id: Value(id),
      name: Value(name),
      link: Value(link),
      feedType: Value(feedType),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory Feed.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feed(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      link: serializer.fromJson<String>(json['link']),
      feedType: $FeedsTable.$converterfeedType.fromJson(
        serializer.fromJson<String>(json['feedType']),
      ),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'link': serializer.toJson<String>(link),
      'feedType': serializer.toJson<String>(
        $FeedsTable.$converterfeedType.toJson(feedType),
      ),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  Feed copyWith({
    int? id,
    String? name,
    String? link,
    FeedType? feedType,
    DateTime? fetchedAt,
  }) => Feed(
    id: id ?? this.id,
    name: name ?? this.name,
    link: link ?? this.link,
    feedType: feedType ?? this.feedType,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  Feed copyWithCompanion(FeedsCompanion data) {
    return Feed(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      link: data.link.present ? data.link.value : this.link,
      feedType: data.feedType.present ? data.feedType.value : this.feedType,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feed(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('link: $link, ')
          ..write('feedType: $feedType, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, link, feedType, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feed &&
          other.id == this.id &&
          other.name == this.name &&
          other.link == this.link &&
          other.feedType == this.feedType &&
          other.fetchedAt == this.fetchedAt);
}

class FeedsCompanion extends UpdateCompanion<Feed> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> link;
  final Value<FeedType> feedType;
  final Value<DateTime> fetchedAt;
  const FeedsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.link = const Value.absent(),
    this.feedType = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  FeedsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String link,
    required FeedType feedType,
    this.fetchedAt = const Value.absent(),
  }) : name = Value(name),
       link = Value(link),
       feedType = Value(feedType);
  static Insertable<Feed> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? link,
    Expression<String>? feedType,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (link != null) 'link': link,
      if (feedType != null) 'feed_type': feedType,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  FeedsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? link,
    Value<FeedType>? feedType,
    Value<DateTime>? fetchedAt,
  }) {
    return FeedsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      feedType: feedType ?? this.feedType,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (feedType.present) {
      map['feed_type'] = Variable<String>(
        $FeedsTable.$converterfeedType.toSql(feedType.value),
      );
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('link: $link, ')
          ..write('feedType: $feedType, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class $FeedItemsTable extends FeedItems
    with TableInfo<$FeedItemsTable, FeedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedMeta = const VerificationMeta(
    'published',
  );
  @override
  late final GeneratedColumn<DateTime> published = GeneratedColumn<DateTime>(
    'published',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedIdMeta = const VerificationMeta('feedId');
  @override
  late final GeneratedColumn<int> feedId = GeneratedColumn<int>(
    'feed_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES feeds (id)',
    ),
  );
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
    'hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isMarkedMeta = const VerificationMeta(
    'isMarked',
  );
  @override
  late final GeneratedColumn<bool> isMarked = GeneratedColumn<bool>(
    'is_marked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_marked" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  static const VerificationMeta _wasReadMeta = const VerificationMeta(
    'wasRead',
  );
  @override
  late final GeneratedColumn<bool> wasRead = GeneratedColumn<bool>(
    'was_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_read" IN (0, 1))',
    ),
    clientDefault: () => false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    link,
    published,
    author,
    feedId,
    hash,
    fetchedAt,
    isMarked,
    wasRead,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('published')) {
      context.handle(
        _publishedMeta,
        published.isAcceptableOrUnknown(data['published']!, _publishedMeta),
      );
    } else if (isInserting) {
      context.missing(_publishedMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('feed_id')) {
      context.handle(
        _feedIdMeta,
        feedId.isAcceptableOrUnknown(data['feed_id']!, _feedIdMeta),
      );
    } else if (isInserting) {
      context.missing(_feedIdMeta);
    }
    if (data.containsKey('hash')) {
      context.handle(
        _hashMeta,
        hash.isAcceptableOrUnknown(data['hash']!, _hashMeta),
      );
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    }
    if (data.containsKey('is_marked')) {
      context.handle(
        _isMarkedMeta,
        isMarked.isAcceptableOrUnknown(data['is_marked']!, _isMarkedMeta),
      );
    }
    if (data.containsKey('was_read')) {
      context.handle(
        _wasReadMeta,
        wasRead.isAcceptableOrUnknown(data['was_read']!, _wasReadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      )!,
      published: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}published'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      feedId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}feed_id'],
      )!,
      hash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hash'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      isMarked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_marked'],
      )!,
      wasRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_read'],
      )!,
    );
  }

  @override
  $FeedItemsTable createAlias(String alias) {
    return $FeedItemsTable(attachedDatabase, alias);
  }
}

class FeedItem extends DataClass implements Insertable<FeedItem> {
  final int id;
  final String title;
  final String description;
  final String link;
  final DateTime published;
  final String author;
  final int feedId;
  final String hash;
  final DateTime fetchedAt;
  final bool isMarked;
  final bool wasRead;
  const FeedItem({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.published,
    required this.author,
    required this.feedId,
    required this.hash,
    required this.fetchedAt,
    required this.isMarked,
    required this.wasRead,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['link'] = Variable<String>(link);
    map['published'] = Variable<DateTime>(published);
    map['author'] = Variable<String>(author);
    map['feed_id'] = Variable<int>(feedId);
    map['hash'] = Variable<String>(hash);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['is_marked'] = Variable<bool>(isMarked);
    map['was_read'] = Variable<bool>(wasRead);
    return map;
  }

  FeedItemsCompanion toCompanion(bool nullToAbsent) {
    return FeedItemsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      link: Value(link),
      published: Value(published),
      author: Value(author),
      feedId: Value(feedId),
      hash: Value(hash),
      fetchedAt: Value(fetchedAt),
      isMarked: Value(isMarked),
      wasRead: Value(wasRead),
    );
  }

  factory FeedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      link: serializer.fromJson<String>(json['link']),
      published: serializer.fromJson<DateTime>(json['published']),
      author: serializer.fromJson<String>(json['author']),
      feedId: serializer.fromJson<int>(json['feedId']),
      hash: serializer.fromJson<String>(json['hash']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      isMarked: serializer.fromJson<bool>(json['isMarked']),
      wasRead: serializer.fromJson<bool>(json['wasRead']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'link': serializer.toJson<String>(link),
      'published': serializer.toJson<DateTime>(published),
      'author': serializer.toJson<String>(author),
      'feedId': serializer.toJson<int>(feedId),
      'hash': serializer.toJson<String>(hash),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'isMarked': serializer.toJson<bool>(isMarked),
      'wasRead': serializer.toJson<bool>(wasRead),
    };
  }

  FeedItem copyWith({
    int? id,
    String? title,
    String? description,
    String? link,
    DateTime? published,
    String? author,
    int? feedId,
    String? hash,
    DateTime? fetchedAt,
    bool? isMarked,
    bool? wasRead,
  }) => FeedItem(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    link: link ?? this.link,
    published: published ?? this.published,
    author: author ?? this.author,
    feedId: feedId ?? this.feedId,
    hash: hash ?? this.hash,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    isMarked: isMarked ?? this.isMarked,
    wasRead: wasRead ?? this.wasRead,
  );
  FeedItem copyWithCompanion(FeedItemsCompanion data) {
    return FeedItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      link: data.link.present ? data.link.value : this.link,
      published: data.published.present ? data.published.value : this.published,
      author: data.author.present ? data.author.value : this.author,
      feedId: data.feedId.present ? data.feedId.value : this.feedId,
      hash: data.hash.present ? data.hash.value : this.hash,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      isMarked: data.isMarked.present ? data.isMarked.value : this.isMarked,
      wasRead: data.wasRead.present ? data.wasRead.value : this.wasRead,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('link: $link, ')
          ..write('published: $published, ')
          ..write('author: $author, ')
          ..write('feedId: $feedId, ')
          ..write('hash: $hash, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('isMarked: $isMarked, ')
          ..write('wasRead: $wasRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    link,
    published,
    author,
    feedId,
    hash,
    fetchedAt,
    isMarked,
    wasRead,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.link == this.link &&
          other.published == this.published &&
          other.author == this.author &&
          other.feedId == this.feedId &&
          other.hash == this.hash &&
          other.fetchedAt == this.fetchedAt &&
          other.isMarked == this.isMarked &&
          other.wasRead == this.wasRead);
}

class FeedItemsCompanion extends UpdateCompanion<FeedItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> link;
  final Value<DateTime> published;
  final Value<String> author;
  final Value<int> feedId;
  final Value<String> hash;
  final Value<DateTime> fetchedAt;
  final Value<bool> isMarked;
  final Value<bool> wasRead;
  const FeedItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.link = const Value.absent(),
    this.published = const Value.absent(),
    this.author = const Value.absent(),
    this.feedId = const Value.absent(),
    this.hash = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.isMarked = const Value.absent(),
    this.wasRead = const Value.absent(),
  });
  FeedItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required String link,
    required DateTime published,
    required String author,
    required int feedId,
    required String hash,
    this.fetchedAt = const Value.absent(),
    this.isMarked = const Value.absent(),
    this.wasRead = const Value.absent(),
  }) : title = Value(title),
       description = Value(description),
       link = Value(link),
       published = Value(published),
       author = Value(author),
       feedId = Value(feedId),
       hash = Value(hash);
  static Insertable<FeedItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? link,
    Expression<DateTime>? published,
    Expression<String>? author,
    Expression<int>? feedId,
    Expression<String>? hash,
    Expression<DateTime>? fetchedAt,
    Expression<bool>? isMarked,
    Expression<bool>? wasRead,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (link != null) 'link': link,
      if (published != null) 'published': published,
      if (author != null) 'author': author,
      if (feedId != null) 'feed_id': feedId,
      if (hash != null) 'hash': hash,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (isMarked != null) 'is_marked': isMarked,
      if (wasRead != null) 'was_read': wasRead,
    });
  }

  FeedItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? link,
    Value<DateTime>? published,
    Value<String>? author,
    Value<int>? feedId,
    Value<String>? hash,
    Value<DateTime>? fetchedAt,
    Value<bool>? isMarked,
    Value<bool>? wasRead,
  }) {
    return FeedItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      link: link ?? this.link,
      published: published ?? this.published,
      author: author ?? this.author,
      feedId: feedId ?? this.feedId,
      hash: hash ?? this.hash,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      isMarked: isMarked ?? this.isMarked,
      wasRead: wasRead ?? this.wasRead,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (published.present) {
      map['published'] = Variable<DateTime>(published.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (feedId.present) {
      map['feed_id'] = Variable<int>(feedId.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (isMarked.present) {
      map['is_marked'] = Variable<bool>(isMarked.value);
    }
    if (wasRead.present) {
      map['was_read'] = Variable<bool>(wasRead.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('link: $link, ')
          ..write('published: $published, ')
          ..write('author: $author, ')
          ..write('feedId: $feedId, ')
          ..write('hash: $hash, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('isMarked: $isMarked, ')
          ..write('wasRead: $wasRead')
          ..write(')'))
        .toString();
  }
}

class $PreferencesTable extends Preferences
    with TableInfo<$PreferencesTable, Preference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 1,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FeedItemFonts, String>
  fontFamily = GeneratedColumn<String>(
    'font_family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<FeedItemFonts>($PreferencesTable.$converterfontFamily);
  static const VerificationMeta _fontSizeMeta = const VerificationMeta(
    'fontSize',
  );
  @override
  late final GeneratedColumn<int> fontSize = GeneratedColumn<int>(
    'font_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fontFamily, fontSize];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<Preference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('font_size')) {
      context.handle(
        _fontSizeMeta,
        fontSize.isAcceptableOrUnknown(data['font_size']!, _fontSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fontSizeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Preference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Preference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fontFamily: $PreferencesTable.$converterfontFamily.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}font_family'],
        )!,
      ),
      fontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}font_size'],
      )!,
    );
  }

  @override
  $PreferencesTable createAlias(String alias) {
    return $PreferencesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FeedItemFonts, String, String>
  $converterfontFamily = const EnumNameConverter<FeedItemFonts>(
    FeedItemFonts.values,
  );
}

class Preference extends DataClass implements Insertable<Preference> {
  final int id;
  final FeedItemFonts fontFamily;
  final int fontSize;
  const Preference({
    required this.id,
    required this.fontFamily,
    required this.fontSize,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['font_family'] = Variable<String>(
        $PreferencesTable.$converterfontFamily.toSql(fontFamily),
      );
    }
    map['font_size'] = Variable<int>(fontSize);
    return map;
  }

  PreferencesCompanion toCompanion(bool nullToAbsent) {
    return PreferencesCompanion(
      id: Value(id),
      fontFamily: Value(fontFamily),
      fontSize: Value(fontSize),
    );
  }

  factory Preference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Preference(
      id: serializer.fromJson<int>(json['id']),
      fontFamily: $PreferencesTable.$converterfontFamily.fromJson(
        serializer.fromJson<String>(json['fontFamily']),
      ),
      fontSize: serializer.fromJson<int>(json['fontSize']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fontFamily': serializer.toJson<String>(
        $PreferencesTable.$converterfontFamily.toJson(fontFamily),
      ),
      'fontSize': serializer.toJson<int>(fontSize),
    };
  }

  Preference copyWith({int? id, FeedItemFonts? fontFamily, int? fontSize}) =>
      Preference(
        id: id ?? this.id,
        fontFamily: fontFamily ?? this.fontFamily,
        fontSize: fontSize ?? this.fontSize,
      );
  Preference copyWithCompanion(PreferencesCompanion data) {
    return Preference(
      id: data.id.present ? data.id.value : this.id,
      fontFamily: data.fontFamily.present
          ? data.fontFamily.value
          : this.fontFamily,
      fontSize: data.fontSize.present ? data.fontSize.value : this.fontSize,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Preference(')
          ..write('id: $id, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('fontSize: $fontSize')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fontFamily, fontSize);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Preference &&
          other.id == this.id &&
          other.fontFamily == this.fontFamily &&
          other.fontSize == this.fontSize);
}

class PreferencesCompanion extends UpdateCompanion<Preference> {
  final Value<int> id;
  final Value<FeedItemFonts> fontFamily;
  final Value<int> fontSize;
  const PreferencesCompanion({
    this.id = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.fontSize = const Value.absent(),
  });
  PreferencesCompanion.insert({
    this.id = const Value.absent(),
    required FeedItemFonts fontFamily,
    required int fontSize,
  }) : fontFamily = Value(fontFamily),
       fontSize = Value(fontSize);
  static Insertable<Preference> custom({
    Expression<int>? id,
    Expression<String>? fontFamily,
    Expression<int>? fontSize,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fontFamily != null) 'font_family': fontFamily,
      if (fontSize != null) 'font_size': fontSize,
    });
  }

  PreferencesCompanion copyWith({
    Value<int>? id,
    Value<FeedItemFonts>? fontFamily,
    Value<int>? fontSize,
  }) {
    return PreferencesCompanion(
      id: id ?? this.id,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fontFamily.present) {
      map['font_family'] = Variable<String>(
        $PreferencesTable.$converterfontFamily.toSql(fontFamily.value),
      );
    }
    if (fontSize.present) {
      map['font_size'] = Variable<int>(fontSize.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesCompanion(')
          ..write('id: $id, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('fontSize: $fontSize')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FeedsTable feeds = $FeedsTable(this);
  late final $FeedItemsTable feedItems = $FeedItemsTable(this);
  late final $PreferencesTable preferences = $PreferencesTable(this);
  late final FeedItemsDao feedItemsDao = FeedItemsDao(this as AppDatabase);
  late final FeedsDao feedsDao = FeedsDao(this as AppDatabase);
  late final PreferencesDao preferencesDao = PreferencesDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    feeds,
    feedItems,
    preferences,
  ];
}

typedef $$FeedsTableCreateCompanionBuilder =
    FeedsCompanion Function({
      Value<int> id,
      required String name,
      required String link,
      required FeedType feedType,
      Value<DateTime> fetchedAt,
    });
typedef $$FeedsTableUpdateCompanionBuilder =
    FeedsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> link,
      Value<FeedType> feedType,
      Value<DateTime> fetchedAt,
    });

final class $$FeedsTableReferences
    extends BaseReferences<_$AppDatabase, $FeedsTable, Feed> {
  $$FeedsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FeedItemsTable, List<FeedItem>>
  _feedItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.feedItems,
    aliasName: 'feeds__id__feed_items__feed_id',
  );

  $$FeedItemsTableProcessedTableManager get feedItemsRefs {
    final manager = $$FeedItemsTableTableManager(
      $_db,
      $_db.feedItems,
    ).filter((f) => f.feedId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FeedsTableFilterComposer extends Composer<_$AppDatabase, $FeedsTable> {
  $$FeedsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FeedType, FeedType, String> get feedType =>
      $composableBuilder(
        column: $table.feedType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> feedItemsRefs(
    Expression<bool> Function($$FeedItemsTableFilterComposer f) f,
  ) {
    final $$FeedItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.feedId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableFilterComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedsTable> {
  $$FeedsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedType => $composableBuilder(
    column: $table.feedType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedsTable> {
  $$FeedsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedType, String> get feedType =>
      $composableBuilder(column: $table.feedType, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  Expression<T> feedItemsRefs<T extends Object>(
    Expression<T> Function($$FeedItemsTableAnnotationComposer a) f,
  ) {
    final $$FeedItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedItems,
      getReferencedColumn: (t) => t.feedId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FeedsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedsTable,
          Feed,
          $$FeedsTableFilterComposer,
          $$FeedsTableOrderingComposer,
          $$FeedsTableAnnotationComposer,
          $$FeedsTableCreateCompanionBuilder,
          $$FeedsTableUpdateCompanionBuilder,
          (Feed, $$FeedsTableReferences),
          Feed,
          PrefetchHooks Function({bool feedItemsRefs})
        > {
  $$FeedsTableTableManager(_$AppDatabase db, $FeedsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> link = const Value.absent(),
                Value<FeedType> feedType = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => FeedsCompanion(
                id: id,
                name: name,
                link: link,
                feedType: feedType,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String link,
                required FeedType feedType,
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => FeedsCompanion.insert(
                id: id,
                name: name,
                link: link,
                feedType: feedType,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FeedsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({feedItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (feedItemsRefs) db.feedItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feedItemsRefs)
                    await $_getPrefetchedData<Feed, $FeedsTable, FeedItem>(
                      currentTable: table,
                      referencedTable: $$FeedsTableReferences
                          ._feedItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FeedsTableReferences(db, table, p0).feedItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.feedId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FeedsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedsTable,
      Feed,
      $$FeedsTableFilterComposer,
      $$FeedsTableOrderingComposer,
      $$FeedsTableAnnotationComposer,
      $$FeedsTableCreateCompanionBuilder,
      $$FeedsTableUpdateCompanionBuilder,
      (Feed, $$FeedsTableReferences),
      Feed,
      PrefetchHooks Function({bool feedItemsRefs})
    >;
typedef $$FeedItemsTableCreateCompanionBuilder =
    FeedItemsCompanion Function({
      Value<int> id,
      required String title,
      required String description,
      required String link,
      required DateTime published,
      required String author,
      required int feedId,
      required String hash,
      Value<DateTime> fetchedAt,
      Value<bool> isMarked,
      Value<bool> wasRead,
    });
typedef $$FeedItemsTableUpdateCompanionBuilder =
    FeedItemsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<String> link,
      Value<DateTime> published,
      Value<String> author,
      Value<int> feedId,
      Value<String> hash,
      Value<DateTime> fetchedAt,
      Value<bool> isMarked,
      Value<bool> wasRead,
    });

final class $$FeedItemsTableReferences
    extends BaseReferences<_$AppDatabase, $FeedItemsTable, FeedItem> {
  $$FeedItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FeedsTable _feedIdTable(_$AppDatabase db) =>
      db.feeds.createAlias('feed_items__feed_id__feeds__id');

  $$FeedsTableProcessedTableManager get feedId {
    final $_column = $_itemColumn<int>('feed_id')!;

    final manager = $$FeedsTableTableManager(
      $_db,
      $_db.feeds,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_feedIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FeedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get published => $composableBuilder(
    column: $table.published,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMarked => $composableBuilder(
    column: $table.isMarked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasRead => $composableBuilder(
    column: $table.wasRead,
    builder: (column) => ColumnFilters(column),
  );

  $$FeedsTableFilterComposer get feedId {
    final $$FeedsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feedId,
      referencedTable: $db.feeds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedsTableFilterComposer(
            $db: $db,
            $table: $db.feeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get published => $composableBuilder(
    column: $table.published,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMarked => $composableBuilder(
    column: $table.isMarked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasRead => $composableBuilder(
    column: $table.wasRead,
    builder: (column) => ColumnOrderings(column),
  );

  $$FeedsTableOrderingComposer get feedId {
    final $$FeedsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feedId,
      referencedTable: $db.feeds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedsTableOrderingComposer(
            $db: $db,
            $table: $db.feeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedItemsTable> {
  $$FeedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<DateTime> get published =>
      $composableBuilder(column: $table.published, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<bool> get isMarked =>
      $composableBuilder(column: $table.isMarked, builder: (column) => column);

  GeneratedColumn<bool> get wasRead =>
      $composableBuilder(column: $table.wasRead, builder: (column) => column);

  $$FeedsTableAnnotationComposer get feedId {
    final $$FeedsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feedId,
      referencedTable: $db.feeds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedsTableAnnotationComposer(
            $db: $db,
            $table: $db.feeds,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedItemsTable,
          FeedItem,
          $$FeedItemsTableFilterComposer,
          $$FeedItemsTableOrderingComposer,
          $$FeedItemsTableAnnotationComposer,
          $$FeedItemsTableCreateCompanionBuilder,
          $$FeedItemsTableUpdateCompanionBuilder,
          (FeedItem, $$FeedItemsTableReferences),
          FeedItem,
          PrefetchHooks Function({bool feedId})
        > {
  $$FeedItemsTableTableManager(_$AppDatabase db, $FeedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> link = const Value.absent(),
                Value<DateTime> published = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<int> feedId = const Value.absent(),
                Value<String> hash = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<bool> isMarked = const Value.absent(),
                Value<bool> wasRead = const Value.absent(),
              }) => FeedItemsCompanion(
                id: id,
                title: title,
                description: description,
                link: link,
                published: published,
                author: author,
                feedId: feedId,
                hash: hash,
                fetchedAt: fetchedAt,
                isMarked: isMarked,
                wasRead: wasRead,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String description,
                required String link,
                required DateTime published,
                required String author,
                required int feedId,
                required String hash,
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<bool> isMarked = const Value.absent(),
                Value<bool> wasRead = const Value.absent(),
              }) => FeedItemsCompanion.insert(
                id: id,
                title: title,
                description: description,
                link: link,
                published: published,
                author: author,
                feedId: feedId,
                hash: hash,
                fetchedAt: fetchedAt,
                isMarked: isMarked,
                wasRead: wasRead,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FeedItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({feedId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (feedId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.feedId,
                                referencedTable: $$FeedItemsTableReferences
                                    ._feedIdTable(db),
                                referencedColumn: $$FeedItemsTableReferences
                                    ._feedIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FeedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedItemsTable,
      FeedItem,
      $$FeedItemsTableFilterComposer,
      $$FeedItemsTableOrderingComposer,
      $$FeedItemsTableAnnotationComposer,
      $$FeedItemsTableCreateCompanionBuilder,
      $$FeedItemsTableUpdateCompanionBuilder,
      (FeedItem, $$FeedItemsTableReferences),
      FeedItem,
      PrefetchHooks Function({bool feedId})
    >;
typedef $$PreferencesTableCreateCompanionBuilder =
    PreferencesCompanion Function({
      Value<int> id,
      required FeedItemFonts fontFamily,
      required int fontSize,
    });
typedef $$PreferencesTableUpdateCompanionBuilder =
    PreferencesCompanion Function({
      Value<int> id,
      Value<FeedItemFonts> fontFamily,
      Value<int> fontSize,
    });

class $$PreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $PreferencesTable> {
  $$PreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FeedItemFonts, FeedItemFonts, String>
  get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferencesTable> {
  $$PreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferencesTable> {
  $$PreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedItemFonts, String> get fontFamily =>
      $composableBuilder(
        column: $table.fontFamily,
        builder: (column) => column,
      );

  GeneratedColumn<int> get fontSize =>
      $composableBuilder(column: $table.fontSize, builder: (column) => column);
}

class $$PreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreferencesTable,
          Preference,
          $$PreferencesTableFilterComposer,
          $$PreferencesTableOrderingComposer,
          $$PreferencesTableAnnotationComposer,
          $$PreferencesTableCreateCompanionBuilder,
          $$PreferencesTableUpdateCompanionBuilder,
          (
            Preference,
            BaseReferences<_$AppDatabase, $PreferencesTable, Preference>,
          ),
          Preference,
          PrefetchHooks Function()
        > {
  $$PreferencesTableTableManager(_$AppDatabase db, $PreferencesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<FeedItemFonts> fontFamily = const Value.absent(),
                Value<int> fontSize = const Value.absent(),
              }) => PreferencesCompanion(
                id: id,
                fontFamily: fontFamily,
                fontSize: fontSize,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required FeedItemFonts fontFamily,
                required int fontSize,
              }) => PreferencesCompanion.insert(
                id: id,
                fontFamily: fontFamily,
                fontSize: fontSize,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreferencesTable,
      Preference,
      $$PreferencesTableFilterComposer,
      $$PreferencesTableOrderingComposer,
      $$PreferencesTableAnnotationComposer,
      $$PreferencesTableCreateCompanionBuilder,
      $$PreferencesTableUpdateCompanionBuilder,
      (
        Preference,
        BaseReferences<_$AppDatabase, $PreferencesTable, Preference>,
      ),
      Preference,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FeedsTableTableManager get feeds =>
      $$FeedsTableTableManager(_db, _db.feeds);
  $$FeedItemsTableTableManager get feedItems =>
      $$FeedItemsTableTableManager(_db, _db.feedItems);
  $$PreferencesTableTableManager get preferences =>
      $$PreferencesTableTableManager(_db, _db.preferences);
}
