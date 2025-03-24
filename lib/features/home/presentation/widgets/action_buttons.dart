import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/save.svg' , width: 24, height: 24,),
        const SizedBox(width: 8),
         SvgPicture.asset('assets/images/Menu Dots.svg' , width: 24, height: 24,),
      ],
    );
  }
}
