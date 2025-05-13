import 'package:buy_from_egypt/features/home/presentation/views/market_view_ex.dart';
import 'package:buy_from_egypt/features/home/presentation/views/order1_view_ex.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_sell_widget.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/post.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeBody(), // Only Home page has AppBar inside it
    MarketViewEx(),
    const Order1ViewEx(),
  ];

  void _onNavTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        items: defaultNavItems,
        currentIndex: currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(), // ✅ AppBar موجود بس هنا
        const CustomSellWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => const Post(),
          ),
        ),
      ],
    );
  }
}
