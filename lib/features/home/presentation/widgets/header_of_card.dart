import 'package:flutter/material.dart';
import 'user_section.dart';
import 'action_buttons.dart';

class HeaderOfCard extends StatelessWidget {
  const HeaderOfCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserSection(
                timeAgo: '2 h ago',
              ),
              ActionButtons(),
            ],
          ),
        ],
      ),
    );
  }
}
