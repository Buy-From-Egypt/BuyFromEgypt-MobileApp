import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'industry_item.dart';

class IndustrySection extends StatefulWidget {
  const IndustrySection({super.key});

  @override
  State<IndustrySection> createState() => _IndustrySectionState();
}

class _IndustrySectionState extends State<IndustrySection> {
  bool isExpanded = true;

  final List<Map<String, String>> industries = const [
    {'title': 'Agriculture & Food', 'count': '300'},
    {'title': 'Manufacturing & Industrial', 'count': '50'},
    {'title': 'Consumer Goods & Retail', 'count': '50'},
    {'title': 'Energy & Natural Resources', 'count': '50'},
    {'title': 'Pharmaceuticals', 'count': '50'},
    {'title': 'Technology & Electronics', 'count': '50'},
    {'title': 'Automotive', 'count': '50'},
    {'title': 'Construction & Real Estate', 'count': '50'},
  ];

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
                    ...industries.map(
                      (item) => IndustryItem(
                        title: item['title']!,
                        count: item['count']!,
                      ),
                    ).toList(),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
