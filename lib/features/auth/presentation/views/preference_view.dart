import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/industry_selection.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/preference_header.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/supplier_type_selector.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/switch.dart';
import 'package:flutter/material.dart';

class PreferenceView extends StatefulWidget {
  const PreferenceView({super.key});

  @override
  State<PreferenceView> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends State<PreferenceView> {
  bool isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PreferenceHeader(),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: IndustrySelection(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SupplierTypeSelector(
                title: 'Preferred Supplier Type',
                selectedSupplierType: 'Small Businesses',
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SupplierTypeSelector(
                title: 'Order Quantity',
                selectedSupplierType: 'Small orders',
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SupplierTypeSelector(
                title: 'Preferred Shipping Method',
                selectedSupplierType: 'Air Freight',
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Receive alerts for new products',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  ActiveColorSwitch(
                    initialValue: true,
                    scale: 0.7,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(onPressed: () {}, text: 'Submit', isLoading: false,),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
