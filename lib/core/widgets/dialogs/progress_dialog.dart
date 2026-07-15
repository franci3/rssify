import 'package:flutter/cupertino.dart';
import 'package:stockholm/stockholm.dart';

Future<T?> showProgressDialog<T>(
  BuildContext context,
  Future<T> Function() process,
) async {
  showStockholmProgressDialog(
    context: context,
    builder: (context) {
      return const StockholmActivityIndicator();
    },
  );
  final result = await process();
  if (context.mounted) Navigator.of(context).pop();
  return result;
}
