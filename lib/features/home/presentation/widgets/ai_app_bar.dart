import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/ai_profile.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/profile_icon.dart';
import 'package:flutter/material.dart';

class AiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AiAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primary,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const SvgIcon(
                  path: 'assets/images/bach_g.svg',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const AiProfileIcon(
                backgroundColor: AppColors.background,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export Assistant',
                    style: Styles.textStyle14w,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Personal chat bot assistant',
                    style: Styles.textStyle14c7,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
