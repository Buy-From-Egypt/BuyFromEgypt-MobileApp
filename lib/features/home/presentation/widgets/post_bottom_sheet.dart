import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddToPostBottomSheet extends StatelessWidget {
  const AddToPostBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: AppColors.c9,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stack for handle and close button
          Stack(
            clipBehavior: Clip.none, // Add this line
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 36,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.5),
                    color: AppColors.c10,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    color: Color(0xFFECECEC),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Centered Text
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Add to your post',
                    style: Styles.textStyle16bl,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomSheetItem(
                iconPath: 'assets/images/black image.svg',
                label: 'Photo',
                onTap: () => print('Photo tapped'),
              ),
              _BottomSheetItem(
                iconPath: 'assets/images/black video.svg',
                label: 'Video',
                onTap: () => print('Video tapped'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomSheetItem(
                iconPath: 'assets/images/black calendar.svg',
                label: 'Event',
                onTap: () => print('Event tapped'),
              ),
              _BottomSheetItem(
                iconPath: 'assets/images/Black link.svg',
                label: 'Link',
                onTap: () => print('Link tapped'),
                iconSize: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _BottomSheetItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;
  final double iconSize;

  const _BottomSheetItem({
    required this.iconPath,
    required this.label,
    required this.onTap,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: iconSize,
                  width: iconSize,
                  color: Colors.black,
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: Styles.textStyle16bl,
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              padding: const EdgeInsets.all(2.0),
              child: const Center(
                child: Icon(Icons.add, size: 10, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
