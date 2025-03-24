import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';

class UserSection extends StatelessWidget {
  const UserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ProfileImage(),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetails(),
            SizedBox(height: 4),
            Text(
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
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Theo James',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 8),
        Text(
          '2 h ago',
          style: TextStyle(
            color: AppColors.c5,
            fontSize: 11,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
