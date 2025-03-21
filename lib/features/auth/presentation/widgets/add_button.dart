import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.c7,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Add',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                height: 1.43,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/images/plus.svg',
              height: 18,
              width: 18,
            ),
          ],
        ),
      ),
    );
  }
}
