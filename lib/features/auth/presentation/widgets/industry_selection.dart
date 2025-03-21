import 'package:buy_from_egypt/features/auth/presentation/widgets/add_button.dart';
import 'package:flutter/material.dart';
import 'industry_item.dart';

class IndustrySelection extends StatelessWidget {
  const IndustrySelection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your Industry',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
            height: 1.56,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IndustryItem(title: 'Agriculture & Food'),
            SizedBox(width: 12),
            Expanded(child: IndustryItem(title: 'Petroleum & Energy')),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: IndustryItem(title: 'Construction & Building Materials'),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IndustryItem(title: 'Electronics'),
            SizedBox(width: 10),
            Expanded(child: IndustryItem(title: 'Chemicals & Fertilizers')),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: IndustryItem(title: 'Textiles & Garments'),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: IndustryItem(title: 'Handicrafts & Furniture')),
            SizedBox(width: 12),
            AddButton(),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
