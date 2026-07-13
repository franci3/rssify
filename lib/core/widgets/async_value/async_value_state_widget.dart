import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:stockholm/stockholm.dart';

class AsyncValueStateWidget<T> extends StatelessWidget {
  const AsyncValueStateWidget({
    super.key,
    required this.asyncValueState,
    required this.onData,
  });
  final AsyncValue<T> asyncValueState;
  final Widget Function(T) onData;

  @override
  Widget build(BuildContext context) {
    return asyncValueState.when(
      data: onData,
      error: (e, st) {
        Logger('AsyncValueState').severe('error while asyncValue', e, st);
        return const Text('An error occurred');
      },
      loading: () => const StockholmActivityIndicator(),
    );
  }
}
