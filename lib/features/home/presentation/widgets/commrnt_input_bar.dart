import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';

class CommentInputBar extends StatelessWidget {
  const CommentInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000), // Very soft black (6% opacity)
            offset: Offset(0, -4), // Shadow goes upward
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0)
                  .copyWith(top: 8, bottom: 12),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/theo.jpeg'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Add Comment.....',
                        hintStyle: Styles.textStyle14c5,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/image.svg'),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/link.svg'),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/video.svg'),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/images/calendar.svg'),
                  const Spacer(),
                  const Text('Send', style: Styles.textStyle18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
