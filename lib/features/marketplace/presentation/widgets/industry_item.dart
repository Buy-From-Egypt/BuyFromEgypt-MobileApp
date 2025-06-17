import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class IndustryItem extends StatefulWidget {
  final String title;
  final String count;
  final VoidCallback? onTap;

  const IndustryItem({
    super.key,
    required this.title,
    required this.count,
    this.onTap,
  });

  @override
  State<IndustryItem> createState() => _IndustryItemState();
}

class _IndustryItemState extends State<IndustryItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => selected = !selected);
        widget.onTap?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.title,
                style: Styles.textStyle14.copyWith(
                  color: selected ? AppColors.primary : null,
                  fontWeight: selected ? FontWeight.w700 : null,
                ),
              ),
            ),
            Text(
              "(${widget.count})",
              style: Styles.textStyle14,
            ),
          ],
        ),
      ),
    );
  }
}
