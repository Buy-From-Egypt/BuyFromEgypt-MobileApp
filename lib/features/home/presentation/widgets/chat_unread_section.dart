import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class ChatUnreadSection extends StatelessWidget {
  const ChatUnreadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: const Row(
        children: [
          SvgIcon(
              path: 'assets/images/message_markett.svg', width: 18, height: 18),
          SizedBox(width: 8),
          Text('Unread Messages', style: Styles.textStyle13c7),
        ],
      ),
    );
  }
}
