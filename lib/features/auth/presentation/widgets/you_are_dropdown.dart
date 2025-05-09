import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class YouAre extends StatelessWidget {
  const YouAre({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You Are',
          style: Styles.textStyle14
              .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: 327,
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.c7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Exporter',
                  style: Styles.textStyle14.copyWith(color: AppColors.c7),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/images/drop down.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
