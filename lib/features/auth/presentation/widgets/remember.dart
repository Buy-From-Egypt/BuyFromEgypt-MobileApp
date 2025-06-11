import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Remember extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final bool initialValue;

  const Remember({
    super.key,
    this.onChanged,
    this.initialValue = false,
  });

  @override
  State<Remember> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                  widget.onChanged?.call(isChecked);
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'Remember me',
                style: TextStyle(
                  color: AppColors.c5,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
