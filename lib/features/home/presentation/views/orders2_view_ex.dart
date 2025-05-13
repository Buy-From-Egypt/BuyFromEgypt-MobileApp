import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/extensions.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/custom_app_bar_market.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/order2_card.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/order_filter_tabs.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/order_search_bar.dart';
import 'package:flutter/material.dart';

class Orders2ViewEx extends StatefulWidget {
  const Orders2ViewEx({super.key});

  @override
  State<Orders2ViewEx> createState() => _Orders2ViewExState();
}

class _Orders2ViewExState extends State<Orders2ViewEx> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        items: defaultNavItems,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      backgroundColor: AppColors.white,
      appBar: CustomAppBarMarket(title: 'Orders'),
      body: Column(
        children: [
          Divider(
            color: AppColors.c5,
            height: context.screenHeight * 0.0015,
            thickness: 1,
          ),
          SizedBox(height: context.screenHeight * 0.01),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OrderFilterTabs(),
                  SizedBox(height: context.screenHeight * 0.02),
                  const OrderSearchBar(),
                  SizedBox(height: context.screenHeight * 0.02),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                            bottom: context.screenHeight * 0.015),
                        child: const Order2Card(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
