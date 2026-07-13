import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rssify/core/constants.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/theme.dart';
import 'package:rssify/features/feed_item_list/presentation/feed_item_list_widget.dart';
import 'package:rssify/features/feed_item_list/presentation/feed_item_widget.dart';
import 'package:rssify/features/sidebar/presentation/sidebar_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    debugPrint(
      '${record.level.name}: [${record.loggerName}] ${record.message}',
    );
    if (record.error != null) {
      debugPrint('Error: ${record.error}');
    }
    if (record.stackTrace != null) {
      debugPrint('StackTrace:\n${record.stackTrace}');
    }
  });
  runApp(const ProviderScope(child: Rssify()));
}

class Rssify extends StatelessWidget {
  const Rssify({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: GlobalTheme.globalAppTheme,
      home: const RssifyHome(),
    );
  }
}

class RssifyHome extends StatefulWidget {
  const RssifyHome({super.key});

  @override
  State<RssifyHome> createState() => _RssifyHomeState();
}

class _RssifyHomeState extends State<RssifyHome> {
  FeedItem? _feedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarWidget(),
          FeedItemListWidget(
            onSelected: (feedItem) {
              setState(() {
                _feedItem = feedItem;
              });
            },
          ),
          Expanded(child: FeedItemWidget(feedItem: _feedItem)),
        ],
      ),
    );
  }
}
