import 'package:buy_from_egypt/core/utils/extentions.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class OrderFilterTabs extends StatefulWidget {
  const OrderFilterTabs({super.key});

  @override
  State<OrderFilterTabs> createState() => _OrderFilterTabsState();
}

class _OrderFilterTabsState extends State<OrderFilterTabs> {
  bool isNewSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.055,
      padding: EdgeInsets.all(context.screenWidth * 0.01),
      decoration: BoxDecoration(
        color: const Color(0xFFEAE9DF),
        borderRadius: BorderRadius.circular(context.screenWidth * 0.05),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isNewSelected = true),
              child: _TabButton(label: "New", selected: isNewSelected),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isNewSelected = false),
              child: _TabButton(label: "Requested", selected: !isNewSelected),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabButton({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(context.screenWidth * 0.04),
      ),
      child: Text(
        label,
        style: Styles.textStyle16400,
      ),
    );
  }
}