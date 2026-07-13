import 'package:flutter/material.dart';

class SidebarListTileTextWidget extends StatelessWidget {
  const SidebarListTileTextWidget({super.key, required this.text, this.count});
  final String text;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(text)),
        if (count != null)
          Text(count.toString(), style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
