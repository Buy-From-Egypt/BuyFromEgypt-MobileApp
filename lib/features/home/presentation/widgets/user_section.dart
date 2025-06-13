import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class UserSection extends StatelessWidget {
  final String? timeAgo;

  const UserSection({super.key, this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ProfileImage(
          path: 'assets/images/theo.jpeg',
          width: 48,
          height: 48,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetails(timeAgo: timeAgo), // pass timeAgo down
            const SizedBox(height: 4),
            const Text(
              'Samsung Electronics',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserDetails extends StatelessWidget {
  final String? timeAgo;

  const UserDetails({super.key, this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Theo James',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w800,
          ),
        ),
        if (timeAgo != null) ...[
          const SizedBox(width: 8),
          Text(
            timeAgo!,
            style: const TextStyle(
              color: AppColors.c5,
              fontSize: 11,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
