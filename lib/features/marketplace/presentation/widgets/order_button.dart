import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:solar_icons/solar_icons.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          SizedBox(
            height: 52,
            width: 260,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: EdgeInsets.zero, 
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit',
                      style: Styles.textStyle16c7
                          .copyWith(color: AppColors.newBeige),
                    ),
                    SvgIcon(
                      path: 'assets/images/edit.svg',
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 1),
            ),
            child: Center(
              child: Icon(SolarIconsOutline.bookmark),
            ),
          )
        ],
      ),
    );
  }
}
