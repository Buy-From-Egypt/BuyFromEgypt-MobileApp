import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final bool isSignUpSelected;
  final Function(bool) onTabChange;

  const CustomTabBar({
    super.key,
    required this.isSignUpSelected,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 327,
        height: 56,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 327,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.c2,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment:
                  isSignUpSelected ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Container(
                  width: 156,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => onTabChange(true),
                  child: SizedBox(
                    width: 160,
                    height: 48,
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSignUpSelected
                              ? AppColors.primary
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => onTabChange(false),
                  child: SizedBox(
                    width: 160,
                    height: 48,
                    child: Center(
                      child: Text(
                        "Login",
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSignUpSelected
                              ? Colors.black
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
