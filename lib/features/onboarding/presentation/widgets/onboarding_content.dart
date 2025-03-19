
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String title, description, image;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Styles.textStyle22.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
            Text(
            description,
            style: Styles.textStyle14.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          Image.asset(image, height: 300),
        ],
      ),
    );
  }
}
