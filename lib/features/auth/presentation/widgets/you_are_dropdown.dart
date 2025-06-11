import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class YouAre extends StatefulWidget {
  final Function(String) onUserTypeSelected;
  const YouAre({super.key, required this.onUserTypeSelected});

  @override
  State<YouAre> createState() => _YouAreState();
}

class _YouAreState extends State<YouAre> {
  String selectedUserType = 'Exporter';
  final List<String> userTypes = ['Exporter', 'Importer'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You Are',
          style: Styles.textStyle14
              .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: 327,
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.c7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedUserType,
              isExpanded: true,
              icon: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/images/drop down.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              items: userTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: Styles.textStyle14.copyWith(color: AppColors.c7),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedUserType = newValue;
                  });
                  widget.onUserTypeSelected(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
