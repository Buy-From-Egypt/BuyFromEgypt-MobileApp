import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  Widget _buildStatItem(String value, String label, BuildContext context) {
    return Column(
      children: [
        Text(value, style: Styles.textStyle20),
        Text(label, style: Styles.textStyle12bl),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: Styles.textStyle18800);
  }

  Widget _buildContactItem(
      String svgAssetPath, String text, String text2, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SvgPicture.asset(
            svgAssetPath,
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: Styles.textStyle13600,
          ),
          const SizedBox(width: 10),
          Expanded(
            // Added Expanded to prevent overflow if text2 is long
            child: Text(
              text2,
              style: Styles.textStyle13600pr,
              overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    bool isActive,
    String svgPath,
    String text,
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min, // Ensure row only takes needed space
          children: [
            SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.primary : AppColors.c7,
                BlendMode.srcIn,
              ),
            ),
            if (text.isNotEmpty) const SizedBox(width: 4),
            if (text.isNotEmpty)
              Flexible(
                // Use Flexible to prevent text overflow in small spaces
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Manrope',
                      color: isActive ? AppColors.primary : AppColors.c7,
                      fontWeight:
                          isActive ? FontWeight.w800 : FontWeight.normal,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis for overflow
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        if (isActive)
          Container(
            // Adjusted width for clarity, can be dynamic based on text length if needed
            width: text.isNotEmpty
                ? 120
                : 40, // Increased width for "Company Info"
            height: 3,
            decoration: BoxDecoration(
              color:
                  AppColors.primary, // Using primary color for active indicator
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }

  Widget _buildOverviewCard(
      String title, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(title, style: Styles.textStyle13600),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: Styles.textStyle20),
        ],
      ),
    );
  }

  Widget _buildProgressBar(
      String label, String value, Color color, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Styles.textStyle18800),
          const SizedBox(height: 4),
          Text(label, style: Styles.textStyle13600),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTableRow(String id, String customerName, String product,
      {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              id,
              style: isHeader ? Styles.textStyle13600 : Styles.textStyle13400,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              customerName,
              style: isHeader ? Styles.textStyle13600 : Styles.textStyle13400,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              product,
              style: isHeader ? Styles.textStyle13600 : Styles.textStyle13400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String stars, String percentage, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(stars, style: Styles.textStyle13600),
          ),
          Expanded(
            child: Container(
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(percentage, style: Styles.textStyle13600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: [
                // ---------- Header ----------
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/images/phone.jpg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: SvgIcon(
                          path: 'assets/images/Edit.svg',
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                // ---------- Company Info + Colored Background ----------
                Container(
                  color: const Color.fromARGB(
                      255, 236, 238, 228), // ← الخلفية المطلوبة
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Transform.scale(
                                    scale: 1,
                                    child: Image.asset(
                                      'assets/images/samsung.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 60),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Samsung Electronics',
                                        style: Styles.textStyle18500,
                                      ),
                                      Text(
                                          'Computers and Electronics Manufacturing',
                                          style: Styles.textStyle13400)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ---------- Stats & Buttons ----------
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatItem('2.3K', 'Followers', context),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  width: 1,
                                  height: 30,
                                  color: AppColors.c7,
                                ),
                                _buildStatItem('220', 'Following', context),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  width: 1,
                                  height: 30,
                                  color: AppColors.c7,
                                ),
                                _buildStatItem('80', 'Post', context),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.c7,
                                      foregroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                    ),
                                    child: const Text('Message',
                                        style: Styles.textStyle14pr),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                      ),
                                      child: const Text(
                                        'Follow',
                                        style: Styles.textStyle14w,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        // ---------- Navigation Tabs ----------
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildNavItem(
                                      true,
                                      'assets/images/company_icon.svg',
                                      'Company Info',
                                      context),
                                  _buildNavItem(
                                      false,
                                      'assets/images/market_icon.svg',
                                      '',
                                      context),
                                  _buildNavItem(
                                      false,
                                      'assets/images/Pen New Square.svg',
                                      '',
                                      context),
                                  _buildNavItem(false,
                                      'assets/images/ratee.svg', '', context),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Divider aligned with nav row
                        const Divider(height: 1),
                      ],
                    ),
                  ),
                ),

                // ---------- Overview Section ----------
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Overview'),
                      const SizedBox(height: 16),

                      // Overview Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildOverviewCard(
                              'Total Products',
                              '226',
                              Icons.inventory_2_outlined,
                              Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildOverviewCard(
                              'Total Orders',
                              '1200',
                              Icons.receipt_long_outlined,
                              Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildOverviewCard(
                              'Customer Rating',
                              '4.7 out of 5',
                              Icons.star_outline,
                              Colors.orange,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ---------- Order Fulfillment Section ----------
                      _buildSectionTitle('Order Fulfillment'),
                      const SizedBox(height: 16),

                      _buildProgressBar(
                          'Received Orders', '1200', Colors.blue, 0.8),
                      _buildProgressBar(
                          'In-Progress Orders', '200', Colors.orange, 0.3),
                      _buildProgressBar(
                          'Completed Orders', '1000', Colors.green, 0.9),

                      const SizedBox(height: 24),

                      // ---------- Orders Table ----------
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            // Table Header
                            _buildOrderTableRow(
                                'ID', 'Customer Name', 'Product',
                                isHeader: true),

                            // Table Rows
                            _buildOrderTableRow(
                                '1200', 'Mohamed Abdelbaset', 'Galaxy'),
                            _buildOrderTableRow(
                                '1119', 'Mohamed Abdelbaset', 'Galaxy'),
                            _buildOrderTableRow(
                                '1118', 'Mohamed Abdelbaset', 'Galaxy'),
                            _buildOrderTableRow(
                                '1117', 'Mohamed Abdelbaset', 'Galaxy'),
                            _buildOrderTableRow(
                                '1116', 'Mohamed Abdelbaset', 'Galaxy'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Pagination
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {}, // Empty onPressed
                            icon: const Icon(Icons.chevron_left),
                          ),
                          TextButton(
                            onPressed: () {}, // Empty onPressed
                            child: const Text('1'),
                          ),
                          TextButton(
                            onPressed: () {}, // Empty onPressed
                            child: const Text('2'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('3'),
                          ),
                          const Text('...'),
                          TextButton(
                            onPressed: () {}, // Empty onPressed
                            child: const Text('20'),
                          ),
                          IconButton(
                            onPressed: () {}, // Empty onPressed
                            icon: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ---------- Customer Satisfaction Section ----------
                      _buildSectionTitle('Customer Satisfaction'),
                      const SizedBox(height: 16),

                      // Rating Summary
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < 4
                                      ? Colors.orange
                                      : Colors.grey.shade300,
                                  size: 20,
                                );
                              }),
                            ),
                            const SizedBox(width: 8),
                            Text('4.7 out of 5',
                                style: Styles.textStyle13600), // Static data
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text('40 Customer review',
                          style: Styles.textStyle13400), // Static data
                      const SizedBox(height: 16),

                      // Rating Breakdown
                      _buildRatingBar('5 Stars', '85%', 0.85), // Static data
                      _buildRatingBar('4 Stars', '10%', 0.10), // Static data
                      _buildRatingBar('3 Stars', '3%', 0.03), // Static data
                      _buildRatingBar('2 Stars', '1%', 0.01), // Static data
                      _buildRatingBar('1 Stars', '1%', 0.01), // Static data

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                // Social Media Icons at the very bottom
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  color: const Color.fromARGB(
                      255, 236, 238, 228), // Consistent background color
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      FaIcon(FontAwesomeIcons.instagram,
                          size: 24, color: AppColors.c7),
                      FaIcon(FontAwesomeIcons.facebookF,
                          size: 24, color: AppColors.c7),
                      FaIcon(FontAwesomeIcons.whatsapp,
                          size: 24, color: AppColors.c7),
                      FaIcon(FontAwesomeIcons.tiktok,
                          size: 24, color: AppColors.c7),
                      FaIcon(FontAwesomeIcons.xing,
                          size: 24,
                          color: AppColors.c7), // Using Xing for X/Twitter
                    ],
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
