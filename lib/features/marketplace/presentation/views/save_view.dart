import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/app_routes.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart'
    show CustomBottomNavigationBar, NavItem;
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/custom_app_bar_market.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/order2_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SaveView extends StatefulWidget {
  final VoidCallback? onPressed;
  const SaveView({super.key, this.onPressed});
  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  int currentIndex = 0;

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
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBarMarket(title: 'Saves'),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: navItems,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildDivider(),
            SizedBox(height: height * 0.12),
            buildEmptyOrderImage(imagePath: 'assets/images/Empty bookmark.svg'),
            SizedBox(height: height * 0.05),
            buildEmptyOrderTexts(),
            SizedBox(height: height * 0.15),
            Orders1Button(
              text: 'Explore Marketplace',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.market);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(
      color: AppColors.c5,
      thickness: 1,
      height: 1,
    );
  }

  Widget buildEmptyOrderImage({required String imagePath}) {
    return SvgPicture.asset(
      imagePath,
      width: width * 0.5,
      height: height * 0.25,
    );
  }

  Widget buildEmptyOrderTexts() {
    return Column(
      children: [
        Text(
          'No saved products yet!',
          style: Styles.textStyle22b,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Text(
            'Start exploring and save the products',
            style: Styles.textStyle14b,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: height * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.12),
          child: Text(
            'you like to find them here later',
            style: Styles.textStyle14b,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
