import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rssify/core/extensions.dart';
import 'package:rssify/core/sizes.dart';
import 'package:rssify/core/widgets/layout/error_text.dart';
import 'package:rssify/features/feed/presentation/controller/feed_notifier.dart';
import 'package:stockholm/stockholm.dart';

class FeedAddWidget extends ConsumerStatefulWidget {
  const FeedAddWidget({super.key, this.initialUrl});
  final String? initialUrl;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedAddWidgetState();
}

class _FeedAddWidgetState extends ConsumerState<FeedAddWidget> {
  final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _urlController;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.initialUrl);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StockholmDialog(
      title: Text(context.l10n.addFeedDialogTitle),
      contents: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          spacing: Sizes.p8,
          children: [
            StockholmTextField(
              placeholder: context.l10n.link,
              controller: _urlController,
              maxLength: 100,
              keyboardType: TextInputType.text,
            ),
            StockholmTextField(
              placeholder: context.l10n.name,
              controller: _nameController,
              maxLength: 50,
              keyboardType: TextInputType.url,
            ),
            if (_hasError) ErrorText(text: context.l10n.addFeedRequired),
            Row(
              spacing: Sizes.p8,
              mainAxisAlignment: .end,
              children: [
                StockholmFlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.l10n.cancel),
                ),
                StockholmFlatButton(
                  important: true,
                  onPressed: _validateInput,
                  child: Text(context.l10n.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _validateInput() {
    if (_nameController.text.isEmpty || _urlController.text.isEmpty) {
      setState(() {
        _hasError = true;
      });
    } else {
      ref
          .read(feedNotifierProvider.notifier)
          .addFeed(name: _nameController.text, url: _urlController.text);

      Navigator.pop(context, true);
    }
  }
}
