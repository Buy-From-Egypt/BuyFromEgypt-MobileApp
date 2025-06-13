import 'package:buy_from_egypt/core/utils/app_colors.dart';
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
                    // TODO: Add your custom dropdown or modal logic here
                  },
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.c7,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Product',
                          style: Styles.textStyle14back,
                        ),
                        const Icon(
                          Icons.expand_more,
                          color: AppColors.background,
                          size: 20,
                        ),
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
                  color: AppColors.c7,
                  borderRadius: BorderRadius.circular(25),
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
          ),
        ),
      ],
    );
  }
}