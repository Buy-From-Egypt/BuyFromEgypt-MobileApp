import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButtonF extends StatelessWidget {
  final Color borderColor;

  const CustomBackButtonF(this.borderColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
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
}
