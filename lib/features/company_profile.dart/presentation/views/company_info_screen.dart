import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/company_profile.dart/presentation/views/product_info_screen.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/post.dart';
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
          Text(
            text2,
            style: Styles.textStyle13600pr,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    bool isActive,
    String svgPath,
    String text,
    BuildContext context, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.primary : AppColors.c7,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            if (text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Manrope',
                    color: isActive ? AppColors.primary : AppColors.c7,
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.normal,
                  ),
                ),
              ),
          ]),
          const SizedBox(height: 8),
          if (isActive)
            Container(
              width: text.isNotEmpty ? 160 : 40,
              height: 3,
              decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(2),
              ),
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
                                    context,
                                    onTap: () {},
                                  ),
                                  _buildNavItem(
                                    false,
                                    'assets/images/market_icon.svg',
                                    '',
                                    context,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ProductInfoScreen()),
                                      );
                                    },
                                  ),
                                  _buildNavItem(
                                    false,
                                    'assets/images/Pen New Square.svg',
                                    '',
                                    context, onTap: () {}, // أنتِ بالفعل هنا
                                  ),
                                  _buildNavItem(
                                    false,
                                    'assets/images/ratee.svg', '', context,
                                    onTap: () {}, // أنتِ بالفعل هنا
                                  ),
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

                // ---------- Main Info Sections ----------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      _buildSectionTitle('About'),
                      const SizedBox(height: 10),
                      const Text(
                          'Our vision and approach\n'
                          'Samsung follows a simple business philosophy:\n'
                          'dedicating its talents and technology to creating\n'
                          'world-class products and services that contribute\n'
                          'to a better global society.',
                          style: Styles.textStyle13600),
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 20),
                      _buildSectionTitle('Contact'),
                      const SizedBox(height: 10),
                      _buildContactItem('assets/images/Phone_ Rounded.svg',
                          'Phone :', ' 0800 072 6786', context),
                      _buildContactItem('assets/images/messages_icon.svg',
                          'Email : ', 'albertkim@samsung.com', context),
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 20),
                      _buildSectionTitle('Address'),
                      const SizedBox(height: 10),
                      _buildContactItem(
                          'assets/images/Point On Map.svg',
                          'Address : ',
                          'Plot 81, Road 90, 5th Settlement',
                          context),
                      _buildContactItem('assets/images/company_g.svg',
                          'City State : ', 'New Cairo, Cairo, Egypt', context),
                      _buildContactItem('assets/images/Location_g.svg',
                          'Post Code : ', 'Post Code: 11865', context),
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 20),
                      _buildSectionTitle('Social Media'),
                    ],
                  ),
                ),

                // ---------- Social Media ----------
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      SvgPicture.asset('assets/images/insta outline.svg',
                          width: 24, height: 24),
                      SizedBox(width: 15),
                      SvgPicture.asset('assets/images/faceb.svg',
                          width: 24, height: 24),
                      SizedBox(width: 15),
                      SvgPicture.asset('assets/images/whatsapp.svg',
                          width: 24, height: 24),
                      SizedBox(width: 15),
                      SvgPicture.asset('assets/images/tiktok.svg',
                          width: 24, height: 24),
                      SizedBox(width: 15),
                      SvgPicture.asset('assets/images/twitter.svg',
                          width: 24, height: 24),
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
