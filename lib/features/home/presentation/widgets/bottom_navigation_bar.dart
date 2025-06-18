<<<<<<< HEAD
=======
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
>>>>>>> 288028117915110d954381bc5d89feb102691a49
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';

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
  void _handleNavigation(int index) {
    widget.onTap(index);
    
    // Navigate to the appropriate view based on the index
    switch (index) {
      case 0: // Home
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1: // Market
        Navigator.pushReplacementNamed(context, AppRoutes.market);
        break;
      case 2: // Orders
        Navigator.pushReplacementNamed(context, AppRoutes.orders1);
        break;
      case 3: // Profile
        // TODO: Add profile route when implemented
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _handleNavigation,
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

  const NavItem({
    required this.label,
    required this.activeIconPath,
    required this.inactiveIconPath,
  });
}

// Default nav items used across the app
const List<NavItem> defaultNavItems = [
  NavItem(
    label: 'Home',
    activeIconPath: 'assets/images/home_b.svg',
    inactiveIconPath: 'assets/images/home.svg',
  ),
  NavItem(
    label: 'Market',
    activeIconPath: 'assets/images/market_b.svg',
    inactiveIconPath: 'assets/images/market.svg',
  ),
  NavItem(
    label: 'Orders',
    activeIconPath: 'assets/images/orders_b.svg',
    inactiveIconPath: 'assets/images/orders.svg',
  ),
  NavItem(
    label: 'Profile',
    activeIconPath: 'assets/images/user_b.svg',
    inactiveIconPath: 'assets/images/user.svg',
  ),
];
