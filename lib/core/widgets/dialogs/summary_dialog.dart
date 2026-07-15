import 'package:flutter/material.dart';
import 'package:rssify/core/extensions.dart';
import 'package:rssify/core/sizes.dart';
import 'package:stockholm/stockholm.dart';

Future<void> showSummaryDialog(
  BuildContext context,
  String summary,
  double textSizes,
  String fontFamily,
) async {
  return await showAdaptiveDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StockholmDialog(
        title: Text(context.l10n.summaryTitle),
        contents: Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.p16,
                horizontal: Sizes.p32,
              ),
              child: Text(
                summary,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: textSizes,
                  fontFamily: fontFamily,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
