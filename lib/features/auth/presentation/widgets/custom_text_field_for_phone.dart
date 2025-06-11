import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFieldForPhone extends StatefulWidget {
  final bool isNumber;
  final String label;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const CustomTextFieldForPhone({
    super.key,
    required this.isNumber,
    required this.label,
    this.onChanged,
    required this.controller,
    this.keyboardType,
  });

  @override
  State<CustomTextFieldForPhone> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldForPhone> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.c4),
      ),
      child: Row(
        children: [
          const SizedBox(width: 24),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/images/emojione_flag-for-egypt.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 18,
                height: 18,
                child: SvgPicture.asset(
                  'assets/images/drop down.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType ?? (widget.isNumber ? TextInputType.number : TextInputType.text),
              cursorColor: Colors.black,
              style: Styles.textStyle14.copyWith(color: AppColors.c6),
              decoration: InputDecoration(
                hintText: widget.label,
                hintStyle:
                    Styles.textStyle14.copyWith(color: AppColors.secondary),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
