import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class AllMessagesTitle extends StatelessWidget {
  const AllMessagesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SvgIcon(
            path: 'assets/images/message_markett.svg', width: 18, height: 18),
        const SizedBox(width: 8),
        Text('All Messages', style: Styles.textStyle13c7),
      ],
    );
  }
}
