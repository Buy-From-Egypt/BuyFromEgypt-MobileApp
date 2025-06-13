import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/views/order2_view.dart';
import 'package:flutter/material.dart';

class Orders1Button extends StatelessWidget {
  const Orders1Button({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Orders2View(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.zero, // Remove internal padding
      ),
      child: Container(
        height: 52,
        width: 327,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add a new product', style: Styles.textStyle166W),
          ],
        ),
      ),
    );
  }
}