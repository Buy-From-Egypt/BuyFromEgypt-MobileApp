import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 10),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text:
                  'Introducing the all-new Galaxy S21 Ultra and Galaxy S21, your ultimate daily companions.\n'
                  'Enjoy smart living with Galaxy AI—edit out unwanted noise from your videos effortlessly and get a personalized briefing of your day from morning to night. '
                  'All of this is powered by Galaxy\'s most advanced processor!\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            TextSpan(
              text: ' #Samsung #GalaxyAI',
              style: TextStyle(
                color: AppColors.danger,
                fontSize: 12,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
