import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<NavItem> items;
  final Function(int) onTap;
  final int currentIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.onTap,
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.c7,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      items: widget.items.map((item) => _buildNavItem(item)).toList(),
    );
  }

  BottomNavigationBarItem _buildNavItem(NavItem item) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        item.inactiveIconPath,
        width: 24,
        height: 24,
      ),
      activeIcon: SvgPicture.asset(
        item.activeIconPath,
        width: 24,
        height: 24,
      ),
      label: item.label,
    );
  }
}

class NavItem {
  final String label;
  final String activeIconPath;
  final String inactiveIconPath;

  NavItem({
    required this.label,
    required this.activeIconPath,
    required this.inactiveIconPath,
  });
}
