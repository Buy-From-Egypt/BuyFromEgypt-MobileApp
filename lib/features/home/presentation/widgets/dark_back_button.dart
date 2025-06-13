// lib/features/home/presentation/widgets/dark_back_button.dart
import 'package:flutter/material.dart';

class DarkBackButton extends StatelessWidget {
  const DarkBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Example size
      height: 40, // Example size
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1), // Or a specific dark color
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black, // Dark icon color
        size: 20,
      ),
    );
  }
}
