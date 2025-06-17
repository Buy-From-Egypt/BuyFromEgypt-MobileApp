import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'industry_item.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/product_service.dart';

class IndustrySection extends StatefulWidget {
  final List<CategoryWithCount> categories;
  final Function(String)? onCategorySelected;
  final bool isLoading;

  const IndustrySection({super.key, required this.categories, this.onCategorySelected, this.isLoading = false});

  @override
  State<IndustrySection> createState() => _IndustrySectionState();
}

class _IndustrySectionState extends State<IndustrySection> {
  bool isExpanded = true;

  void _toggleExpanded() {
    setState(() => isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Industry',
                  style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold , color: AppColors.black)
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded ? 0.5 : 0.0,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: isExpanded
              ? Column(
                  children: [
                    const SizedBox(height: 18),
                    ...widget.categories.map(
                      (category) => IndustryItem(
                        title: category.name,
                        count: category.productCount.toString(),
                        onTap: () {
                          widget.onCategorySelected?.call(category.categoryId);
                        },
                      ),
                    ).toList(),
                    if (widget.isLoading) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: LinearProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
