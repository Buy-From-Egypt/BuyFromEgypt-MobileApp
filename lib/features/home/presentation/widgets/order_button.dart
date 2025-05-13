import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/views/order1_view_ex.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          SizedBox(
            height: 52,
            width: 260,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Order1ViewEx()),
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Request order', style: Styles.textStyle166W),
                    SvgIcon(
                      path: 'assets/images/incline arrow.svg',
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          SvgIcon(path: 'assets/images/save circle.svg', width: 52, height: 52)
        ],
      ),
    );
  }
}
