import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/feed_items.dart';
import 'package:rssify/core/database/schema/feeds.dart';
import 'package:xml/xml.dart';

class ParserService {
  Future<List<FeedItemsCompanion>> parseFeedItemsFromFeed(Feed feed) async {
    final updatedFeed = await _getFeed(feed.link);
    return Isolate.run(() {
      return _parseDocumentToFeedItems(updatedFeed, feed.feedType, feed.id);
    });
  }

  Future<FeedType> getFeedTypeFromUrl(String url) async {
    final content = await _getFeed(url);
    final document = XmlDocument.parse(content);
    final root = document.rootElement;

    final name = root.name.local;
    if (name == 'feed') {
      return FeedType.atom;
    } else if (name == 'rss') {
      final version = root.getAttribute('version');
      if (version != null && version.startsWith('1.')) {
        return FeedType.rssV1;
      }
      return FeedType.rssV2;
    } else if (name == 'RDF') {
      return FeedType.rssV1;
    }

    throw Exception('Unknown feed type: $name');
  }

  Future<String> _getFeed(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.body;
  }

  List<FeedItemsCompanion> _parseDocumentToFeedItems(
    String document,
    FeedType feedType,
    int feedId,
  ) {
    final xmlDoc = XmlDocument.parse(document);

    if (feedType == FeedType.atom) {
      final entries = xmlDoc.findAllElements('entry');
      return entries.map((entry) {
        final title = _getChildText(entry, 'title') ?? 'No Title';
        final link = _getAtomLink(entry);
        final description =
            _getChildText(entry, 'content') ??
            _getChildText(entry, 'summary') ??
            '';
        final dateStr =
            _getChildText(entry, 'published') ??
            _getChildText(entry, 'updated') ??
            '';
        final published = DateTime.tryParse(dateStr) ?? DateTime.now();
        final author = _getAtomAuthor(entry);

        return CustomFeedItemCreator.createWithHash(
          title: title.trim(),
          link: link,
          description: description.trim(),
          published: published,
          author: author.trim(),
          feedId: feedId,
        );
      }).toList();
    } else {
      // RSS
      final items = xmlDoc.findAllElements('item');
      return items.map((item) {
        final title = _getChildText(item, 'title') ?? 'No Title';
        final link = _getChildText(item, 'link') ?? '';
        final description =
            _getChildText(item, 'encoded') ??
            _getChildText(item, 'description') ??
            '';
        final dateStr =
            _getChildText(item, 'pubDate') ?? _getChildText(item, 'date') ?? '';
        final published = DateTime.tryParse(dateStr) ?? DateTime.now();
        final author =
            _getChildText(item, 'creator') ??
            _getChildText(item, 'author') ??
            '';

        return CustomFeedItemCreator.createWithHash(
          title: title.trim(),
          link: link,
          description: description.trim(),
          published: published,
          author: author.trim(),
          feedId: feedId,
        );
      }).toList();
    }
  }

  String? _getChildText(XmlElement parent, String localName) {
    final element = parent.childElements
        .where((e) => e.name.local == localName)
        .firstOrNull;
    return element?.innerText;
  }

  String _getAtomLink(XmlElement entry) {
    final links = entry.childElements.where((e) => e.name.local == 'link');
    if (links.isEmpty) return '';
    final alternate = links
        .where((e) => e.getAttribute('rel') == 'alternate')
        .firstOrNull;
    if (alternate != null) {
      return alternate.getAttribute('href') ?? '';
    }
    return links.first.getAttribute('href') ?? links.first.innerText;
  }

  String _getAtomAuthor(XmlElement entry) {
    final authorEl = entry.childElements
        .where((e) => e.name.local == 'author')
        .firstOrNull;
    if (authorEl == null) return '';
    final nameEl = authorEl.childElements
        .where((e) => e.name.local == 'name')
        .firstOrNull;
    return nameEl?.innerText ?? authorEl.innerText;
  }
}

final parserServiceProvider = Provider<ParserService>((ref) => ParserService());
