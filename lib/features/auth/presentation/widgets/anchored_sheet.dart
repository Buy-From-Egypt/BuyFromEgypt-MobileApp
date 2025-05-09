import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solar_icons/solar_icons.dart';

class Anchoredsheet extends StatelessWidget {
  Anchoredsheet({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.c5,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 30),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Add New Industry',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    SolarIconsBold.closeCircle,
                    color: AppColors.c4,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Industry Name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                height: 1.43,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: 'Enter industry name',
                hintStyle: TextStyle(
                  color: const Color(0xFFA7A99C),
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  height: 1.56,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/images/company.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.c4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Industry Description',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                height: 1.43,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descController,
              maxLines: 3,
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Provide details about this industry',
                hintStyle: TextStyle(
                  color: const Color(0xFFA7A99C),
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  height: 1.56,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.c4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: CustomButton(
                text: 'Submit',
                onPressed: () {},
                isLoading: false,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: CustomButtonWithBorder(
                text: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
                isLoading: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
