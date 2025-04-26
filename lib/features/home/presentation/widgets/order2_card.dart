import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/extensions.dart';

class Order2Card extends StatelessWidget {
  const Order2Card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(context.screenWidth * 0.03),
      ),
      padding: EdgeInsets.all(context.screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: context.screenWidth * 0.06,
                backgroundColor: Colors.black,
              ),
              SizedBox(width: context.screenWidth * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Company Name", style: Styles.textStyle14pr),
                    Text("Engineering & Electronics",
                        style: Styles.textStyle12c16),
                  ],
                ),
              ),
              Container(
                height: context.screenHeight * 0.04,
                width: context.screenWidth * 0.15,
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.03,
                  vertical: context.screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  color: AppColors.waring,
                  borderRadius:
                      BorderRadius.circular(context.screenWidth * 0.03),
                ),
                child: Center(child: Text("New", style: Styles.textStyle14b)),
              ),
            ],
          ),
          SizedBox(height: context.screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _OrderInfoItem(label: "Product", value: "Digital Circuits"),
              _OrderInfoItem(label: "Quantity", value: "3000"),
              _OrderInfoItem(label: "Date", value: "1/1/2025"),
            ],
          ),
          SizedBox(height: context.screenHeight * 0.015),
          Divider(color: AppColors.white),
          SizedBox(height: context.screenHeight * 0.015),
          Row(
            children: const [
              SvgIcon(
                  path: 'assets/images/locationn.svg', width: 22, height: 17),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New York , United States", style: Styles.textStyle13),
                  SizedBox(height: 3),
                  Text("# 457, 2nd Floor", style: Styles.textStyle12c7),
                ],
              ),
            ],
          ),
          SizedBox(height: context.screenHeight * 0.02),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.screenWidth * 0.06),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: context.screenHeight * 0.015),
                  ),
                  onPressed: () {},
                  child: const Text("Decline", style: Styles.textStyle14pr),
                ),
              ),
              SizedBox(width: context.screenWidth * 0.03),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.screenWidth * 0.06),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: context.screenHeight * 0.015),
                  ),
                  onPressed: () {},
                  child: const Text("Accept", style: Styles.textStyle14w),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrderInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _OrderInfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.textStyle12c7),
        Text(value, style: Styles.textStyle13),
      ],
    );
  }
}
