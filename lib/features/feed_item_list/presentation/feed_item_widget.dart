import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/database/database.dart';
import 'package:rssify/core/database/schema/preferences.dart';
import 'package:rssify/core/services/preferences_service.dart';
import 'package:rssify/core/sizes.dart';
import 'package:rssify/core/util/datetime_formats.dart';
import 'package:rssify/core/util/external_launcher.dart';
import 'package:rssify/features/feed_item_list/presentation/controller/feed_item_list_notifier.dart';
import 'package:rssify/features/feed_item_list/presentation/controller/feed_preferences_notifier.dart';
import 'package:stockholm/stockholm.dart';

class FeedItemWidget extends ConsumerStatefulWidget {
  const FeedItemWidget({super.key, this.feedItem});

  final FeedItem? feedItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends ConsumerState<FeedItemWidget> {
  double _textSizes = Sizes.p16;
  String _fontFamily = FeedItemFonts.georgina.value;
  int _fontFamilyIndex = FeedItemFonts.georgina.index;
  bool _markedAsRead = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getUserPreferences());
  }

  @override
  void didUpdateWidget(FeedItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.feedItem != oldWidget.feedItem && widget.feedItem != null) {
      _markedAsRead = widget.feedItem?.isMarked ?? false;
      if (!(widget.feedItem?.wasRead ?? true)) {
        _startReadTimer();
      }
    }
  }

  void _startReadTimer() {
    Timer(
      const Duration(seconds: 1),
      () => ref
          .read(feedItemListNotifierProvider.notifier)
          .markFeedItemAsRead(widget.feedItem!),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.feedItem == null) {
      return const Center(child: Text('Check your RSS Feeds!'));
    }
    return Column(
      children: [
        StockholmToolbar(
          children: [
            Expanded(
              child: StockholmListTileHeader(
                child: Text(
                  widget.feedItem!.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: .ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p4),
              child: Tooltip(
                message: 'Switch font-family',
                child: StockholmDropdownButton(
                  onChanged: (value) {
                    setState(() {
                      switch (value.toInt()) {
                        case 0:
                          _fontFamily = FeedItemFonts.georgina.value;
                          _fontFamilyIndex = FeedItemFonts.georgina.index;
                        case 1:
                          _fontFamily = FeedItemFonts.monaco.value;
                          _fontFamilyIndex = FeedItemFonts.monaco.index;
                        case 2:
                          _fontFamily = FeedItemFonts.charter.value;
                          _fontFamilyIndex = FeedItemFonts.charter.index;
                        case 3:
                          _fontFamily = FeedItemFonts.palatino.value;
                          _fontFamilyIndex = FeedItemFonts.palatino.index;
                        case 4:
                          _fontFamily = FeedItemFonts.avenirNext.value;
                          _fontFamilyIndex = FeedItemFonts.avenirNext.index;
                        case 5:
                          _fontFamily = FeedItemFonts.helveticaNeue.value;
                          _fontFamilyIndex = FeedItemFonts.helveticaNeue.index;
                        default:
                          _fontFamily = FeedItemFonts.georgina.value;
                          _fontFamilyIndex = FeedItemFonts.georgina.index;
                      }
                    });
                    _updatePreferences();
                  },
                  icon: Icon(
                    CupertinoIcons.textformat_alt,
                    color: Theme.of(context).iconTheme.color,
                    size: Sizes.p16,
                  ),
                  items: [
                    StockholmDropdownItem<int>(
                      value: FeedItemFonts.georgina.index,
                      child: Text(FeedItemFonts.georgina.value),
                    ),
                    StockholmDropdownItem<int>(
                      value: FeedItemFonts.monaco.index,
                      child: Text(FeedItemFonts.monaco.value),
                    ),
                    StockholmDropdownItem<int>(
                      value: FeedItemFonts.charter.index,
                      child: Text(FeedItemFonts.charter.value),
                    ),
                    StockholmDropdownItem<int>(
                      value: FeedItemFonts.palatino.index,
                      child: Text(FeedItemFonts.palatino.value),
                    ),
                    StockholmDropdownItem<int>(
                      value: FeedItemFonts.avenirNext.index,
                      child: Text(FeedItemFonts.avenirNext.value),
                    ),
                    StockholmDropdownItem<int>(
                      value: FeedItemFonts.helveticaNeue.index,
                      child: Text(FeedItemFonts.helveticaNeue.value),
                    ),
                  ],
                  value: _fontFamilyIndex,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p4),
              child: Tooltip(
                message: 'Switch font-size',
                child: StockholmDropdownButton(
                  onChanged: (value) {
                    setState(() {
                      _textSizes = value.toDouble();
                    });
                    _updatePreferences();
                  },
                  icon: Icon(
                    CupertinoIcons.textformat_size,
                    color: Theme.of(context).iconTheme.color,
                    size: Sizes.p16,
                  ),
                  items: [
                    StockholmDropdownItem<int>(
                      value: Sizes.p16.toInt(),
                      child: Text(Sizes.p16.toString()),
                    ),
                    StockholmDropdownItem<int>(
                      value: Sizes.p24.toInt(),
                      child: Text(Sizes.p24.toString()),
                    ),
                    StockholmDropdownItem<int>(
                      value: Sizes.p32.toInt(),
                      child: Text(Sizes.p32.toString()),
                    ),
                    StockholmDropdownItem<int>(
                      value: Sizes.p48.toInt(),
                      child: Text(Sizes.p48.toString()),
                    ),
                  ],
                  value: _textSizes,
                ),
              ),
            ),
            Tooltip(
              message: 'Share',
              child: StockholmToolbarButton(
                icon: CupertinoIcons.share,
                onPressed: () => shareUrl(widget.feedItem!.link),
              ),
            ),
            Tooltip(
              message: 'Star this article',
              child: StockholmToolbarButton(
                icon: _markedAsRead
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.star,
                onPressed: () => _markItemAsStarred(widget.feedItem!),
                color: _markedAsRead ? Colors.amber : null,
              ),
            ),
            Tooltip(
              message: 'Summarize article (Coming soon)',
              child: StockholmToolbarButton(
                icon: CupertinoIcons.text_bubble,
                onPressed: () {},
              ),
            ),
            Tooltip(
              message: 'Go to website',
              child: StockholmToolbarButton(
                icon: CupertinoIcons.link,
                onPressed: () => goToWebsite(widget.feedItem!.link),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p24),
              child: SelectionArea(
                selectionControls: desktopTextSelectionControls,
                contextMenuBuilder: (context, selectableRegionState) {
                  return AdaptiveTextSelectionToolbar(
                    anchors: selectableRegionState.contextMenuAnchors,
                    children: selectableRegionState.contextMenuButtonItems.map((
                      buttonItem,
                    ) {
                      return StockholmFlatButton(
                        onPressed: buttonItem.onPressed,
                        child: Text(buttonItem.label ?? ''),
                      );
                    }).toList(),
                  );
                },
                child: Column(
                  children: [
                    Html(
                      data: widget.feedItem!.description,
                      extensions: [
                        TagWrapExtension(
                          tagsToWrap: {'img'},
                          builder: (child) {
                            return Align(
                              alignment: Alignment.center,
                              child: child,
                            );
                          },
                        ),
                      ],
                      style: {
                        'body': Style(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: _fontFamily,
                          fontSize: FontSize(_textSizes),
                          lineHeight: const LineHeight(1.5),
                        ),
                        'p': Style(padding: HtmlPaddings.all(Sizes.p8)),
                        'img': Style(
                          display: Display.block,
                          margin: Margins.only(top: Sizes.p4, bottom: Sizes.p4),
                        ),
                      },
                      onLinkTap: (url, _, _) => goToWebsite(url!),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(widget.feedItem!.author),
                        Text(getFormattedDateTime(widget.feedItem!.published)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _getUserPreferences() async {
    final preferences = await ref
        .read(preferencesServiceProvider)
        .getUserPreference();
    if (preferences != null) {
      setState(() {
        _textSizes = preferences.fontSize.toDouble();
        _fontFamily = preferences.fontFamily.value;
        _fontFamilyIndex = preferences.fontFamily.index;
      });
    }
  }

  void _updatePreferences() {
    ref
        .read(feedPreferenceNotifierProvider.notifier)
        .setUserPreferences(
          fontSize: _textSizes,
          fontFamily: FeedItemFonts.values.elementAt(_fontFamilyIndex),
        );
  }

  void _markItemAsStarred(FeedItem feedItem) {
    ref
        .read(feedItemListNotifierProvider.notifier)
        .markFeedItemAsStarred(widget.feedItem!);
    setState(() {
      _markedAsRead = !_markedAsRead;
    });
  }
}
