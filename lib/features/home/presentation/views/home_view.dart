import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_sell_widget.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/post.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<String> screenTitles = [
    'Home',
    'Market',
    'Orders',
    'Profile',
  ];

  final List<NavItem> navItems = [
    NavItem(
        label: 'Home',
        activeIconPath: 'assets/images/home_b.svg',
        inactiveIconPath: 'assets/images/home.svg'),
    NavItem(
        label: 'Market',
        activeIconPath: 'assets/images/market_b.svg',
        inactiveIconPath: 'assets/images/market.svg'),
    NavItem(
        label: 'Orders',
        activeIconPath: 'assets/images/orders_b.svg',
        inactiveIconPath: 'assets/images/orders.svg'),
    NavItem(
        label: 'Profile',
        activeIconPath: 'assets/images/user_b.svg',
        inactiveIconPath: 'assets/images/user.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: navItems,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      body: Column(
        children: [
          const CustomSellWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Post();
              },
            ),
          ),
        ],
      ),
    );
  }
}
