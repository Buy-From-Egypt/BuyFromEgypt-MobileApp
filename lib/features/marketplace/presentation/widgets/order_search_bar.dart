import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/extentions.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class OrderSearchBar extends StatelessWidget {
  const OrderSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: context.screenHeight * 0.05,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: context.screenHeight * 0.01,
                  horizontal: context.screenWidth * 0.03,
                ),
                hintText: 'Search Order ID',
                hintStyle: Styles.textStyle16400,
                prefixIcon: Icon(Icons.search,
                    size: context.screenWidth * 0.06, color: AppColors.c15),
                filled: true,
                fillColor: AppColors.c13,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: context.screenWidth * 0.03),
        Container(
          height: context.screenHeight * 0.05,
          width: context.screenWidth * 0.18,
          decoration: BoxDecoration(
            color: AppColors.c7,
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(
            child: SvgIcon(
              path: 'assets/images/sort.svg',
              height: 14.62,
              width: 16.13,
            ),
          ),
        ),
      ],
    );
  }
}