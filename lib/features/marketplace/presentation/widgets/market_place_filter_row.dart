import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';

class MarketplaceFilterRow extends StatelessWidget {
  const MarketplaceFilterRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          color: AppColors.c5,
          thickness: 1,
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.addProduct);
                  },
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      color: AppColors.newBeige,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add product',
                          style: Styles.textStyle16,
                        ),
                       SvgIcon(path: 'assets/images/plus.svg', width: 18, height: 18),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 38,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.filter);
                    },
                    child: SvgIcon(
                      path: 'assets/images/Filter.svg',
                      height: 18,
                      width: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}