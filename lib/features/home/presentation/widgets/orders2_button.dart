import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/home/presentation/views/orders2_view_ex.dart';
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
            builder: (context) => const Orders2ViewEx(),
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Add a new product', style: Styles.textStyle166W),
          ],
        ),
      ),
    );
  }
}
