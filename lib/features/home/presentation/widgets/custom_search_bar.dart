import 'package:buy_from_egypt/features/home/presentation/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 47, bottom: 8, right: 24, left: 24),
      child: Column(
        children: [
          SizedBox(
            width: 375,
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(context, borderColor: const Color(0xFF999999)),
                _buildSearchBar(),
                const ProfileImage(
                    path: 'assets/images/theo.jpeg', width: 36, height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 239,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F4),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          SvgPicture.asset(
            'assets/images/search.svg',
            height: 16,
            width: 16,
          ),
          const SizedBox(width: 8),
          const Text(
            'Search',
            style: TextStyle(
              color: Color(0xFF6C7072),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, {Color? borderColor}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/back_f.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
