import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rssify/core/extensions.dart';
import 'package:rssify/core/sizes.dart';
import 'package:stockholm/stockholm.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String exceptionMessage,
) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: true,
    useRootNavigator: true,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(context.l10n.errorDialogTitle),
        content: Text(exceptionMessage),
        actions: [
          Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: StockholmFlatButton(
              onPressed: () => Navigator.pop(context),
              important: true,
              child: Text(context.l10n.dismiss),
            ),
          ),
        ],
      );
    },
  );
}
