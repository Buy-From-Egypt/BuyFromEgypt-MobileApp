import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PendingView extends StatelessWidget {
  const PendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 327,
                  child: Text(
                    'Your Account is Under Review',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 327,
                  child: Text(
                    'Thank you for registering with Buy From Egypt.\nOur team is currently reviewing your documents to ensure a safe and trusted marketplace experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 64,
            ),
            SvgPicture.asset(
              'assets/images/undraw_file-search_cbur 1.svg',
              height: 200,
              width: 327,
            ),
            const SizedBox(
              height: 80,
            ),
            Text(
              'Need assistance?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButton(onPressed: () {}, text: 'Contact Support', isLoading: false,),
            const SizedBox(
              height: 16,
            ),
            CustomButtonWithBorder(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.pendingMoreInfo);
                },
                text: 'More Info', isLoading: false,),
          ],
        ),
      ),
    );
  }
}
