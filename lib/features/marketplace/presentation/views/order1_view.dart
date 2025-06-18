import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/custom_app_bar_market.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/order2_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Order1View extends StatefulWidget {
  const Order1View({super.key});

  @override
  State<Order1View> createState() => _Order1ViewState();
}

class _Order1ViewState extends State<Order1View> {
  int currentIndex = 2;

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
      appBar: CustomAppBarMarket(title: 'Orders'),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: navItems,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildDivider(),
            buildItemsCount(),
            SizedBox(height: height * 0.12),
            buildEmptyOrderImage(imagePath: 'assets/images/order_image.svg'),
            SizedBox(height: height * 0.03),
            buildEmptyOrderTexts(),
            SizedBox(height: height * 0.08),
            const Orders1Button(text: 'Add a new product',),
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

  Widget buildItemsCount() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.015,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text('(0) items'),
        ],
      ),
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
          'No Orders Yet?',
          style: Styles.textStyle22b,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Text(
            'Think of this as the calm before the export boom!',
            style: Styles.textStyle14b,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: height * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.12),
          child: Text(
            'Stay ready, and the right buyers will come knocking.',
            style: Styles.textStyle14b,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}