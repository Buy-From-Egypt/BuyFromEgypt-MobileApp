import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/order_button.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';

class ProductInfoSection extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productDescription;
  final List<Color> availableColors;
  final ValueChanged<int> onColorSelected;
  final Size screenSize;
  final String currencyCode;
  final int selectedColorIndex;
  final bool isDescriptionExpanded;
  final VoidCallback onReadMoreTap;

  const ProductInfoSection({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.availableColors,
    required this.onColorSelected,
    required this.screenSize,
    required this.currencyCode,
    required this.selectedColorIndex,
    required this.isDescriptionExpanded,
    required this.onReadMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.06,
          vertical: screenSize.height * 0.02,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildProductDetails()),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: OrderButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNameAndPrice(),
          SizedBox(height: 24),
          _buildDescriptionAndColors(),
          SizedBox(height: 8),
          _buildDescriptionText(),
        ],
      ),
    );
  }

  Widget _buildNameAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            productName,
            style: Styles.textStyle166pr.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: screenSize.width * 0.045,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          "$productPrice $currencyCode",
          style: Styles.textStyle14.copyWith(
            color: AppColors.primary,
            fontSize: screenSize.width * 0.04,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionAndColors() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Description",
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
            fontSize: screenSize.width * 0.04,
          ),
        ),
        Row(
          children: List.generate(
            availableColors.length,
            (index) => GestureDetector(
              onTap: () => onColorSelected(index),
              child: Container(
                margin: EdgeInsets.only(left: screenSize.width * 0.02),
                width: screenSize.width * 0.035,
                height: screenSize.width * 0.035,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: availableColors[index],
                  border: Border.all(
                    color: selectedColorIndex == index ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionText() {
    final showReadMore = productDescription.length > 100 || productDescription.split('\n').length > 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productDescription.isNotEmpty ? productDescription : "No description available.",
          style: Styles.textStyle14c7.copyWith(
            color: AppColors.c16,
            fontSize: screenSize.width * 0.035,
          ),
          maxLines: isDescriptionExpanded ? null : 3,
          overflow: isDescriptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (showReadMore && !isDescriptionExpanded)
          GestureDetector(
            onTap: onReadMoreTap,
            child: Text(
              "Read more",
              style: Styles.textStyle14info.copyWith(
                fontSize: screenSize.width * 0.035,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        if (showReadMore && isDescriptionExpanded)
          GestureDetector(
            onTap: onReadMoreTap,
            child: Text(
              "Show less",
              style: Styles.textStyle14info.copyWith(
                fontSize: screenSize.width * 0.035,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }
}