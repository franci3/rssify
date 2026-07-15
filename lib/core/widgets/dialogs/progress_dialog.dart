import 'package:flutter/cupertino.dart';
import 'package:stockholm/stockholm.dart';

Future<void> showProgressDialog(
  BuildContext context,
  Future<void> Function() process,
) async {
  showStockholmProgressDialog(
    context: context,
    builder: (context) {
      return const StockholmActivityIndicator();
    },
  );
  await process();
  if (context.mounted) Navigator.of(context).pop();
}
