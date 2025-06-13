import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ShowAllButton extends StatelessWidget {
  const ShowAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          textStyle: Styles.textStyle14pr,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Show All'),
            SizedBox(width: 4),
            Icon(Icons.expand_more, size: 16),
          ],
        ),
      ),
    );
  }
}
