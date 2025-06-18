<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButtonF extends StatelessWidget {
  final Color borderColor;

  const CustomBackButtonF(this.borderColor, {super.key});
=======
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final Color? borderColor;
  final VoidCallback? onTap;

  const CustomBackButton({super.key, this.borderColor, this.onTap});
>>>>>>> 288028117915110d954381bc5d89feb102691a49

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
<<<<<<< HEAD
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
=======
      onTap: onTap ?? () {
        Navigator.pop(context);
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.c5),
>>>>>>> 288028117915110d954381bc5d89feb102691a49
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/back_f.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
} 
>>>>>>> 288028117915110d954381bc5d89feb102691a49
