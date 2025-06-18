import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/switch.dart';
import 'package:flutter/material.dart';

class ToggleRow extends StatefulWidget {
  final String title;
  final ValueChanged<bool>? onToggle;

  const ToggleRow({super.key, required this.title, this.onToggle});

  @override
  State<ToggleRow> createState() => _ToggleRowState();
}

class _ToggleRowState extends State<ToggleRow> {
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title,
            style: Styles.textStyle16
                .copyWith(fontWeight: FontWeight.bold, color: AppColors.black)),
        ActiveColorSwitch(
          onChanged: (value) {
            setState(() => enabled = value);
            widget.onToggle?.call(value);
          },
          scale: 0.7,
        )
      ],
    );
  }
}
