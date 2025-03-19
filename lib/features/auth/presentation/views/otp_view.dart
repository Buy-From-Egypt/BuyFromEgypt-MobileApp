import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Verify Your Account',
                  style: Styles.textStyle16,
                ),
                const SizedBox(height: 20),
                
                CircleAvatar(
                  backgroundColor: AppColors.c4,
                  radius: 30,
                  child: ClipOval(
                    child: SvgPicture.asset(
                      'assets/images/Chat Unread.svg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholderBuilder: (context) => const Icon(
                        Icons.chat_bubble_outline,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Enter the 4-digit verification code we have sent to",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const Text(
                  "mohamedtalaat@gmail.com",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("_", style: TextStyle(fontSize: 24)),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Verify",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
