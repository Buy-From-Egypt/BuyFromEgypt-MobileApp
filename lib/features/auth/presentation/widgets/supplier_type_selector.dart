import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupplierTypeSelector extends StatelessWidget {
  final String title;
  final String selectedSupplierType;

  const SupplierTypeSelector({
    super.key,
    required this.title,
    required this.selectedSupplierType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
            height: 1.56,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.c7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedSupplierType,
                style: const TextStyle(
                  color: AppColors.c7,
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  height: 1.56,
                ),
              ),
              SvgPicture.asset(
                'assets/images/drop down.svg',
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
