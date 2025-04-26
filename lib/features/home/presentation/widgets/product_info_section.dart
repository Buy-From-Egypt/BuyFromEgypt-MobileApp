import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/home/presentation/widgets/order_button.dart';

class ProductInfoSection extends StatelessWidget {
  final String productName;
  final double productPrice;
  final String productDescription;
  final List<Color> availableColors;
  final ValueChanged<int> onColorSelected;
  final Size screenSize;

  const ProductInfoSection({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.availableColors,
    required this.onColorSelected,
    required this.screenSize,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildProductDetails()),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.01),
              child: const OrderButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameAndPrice(),
          SizedBox(height: screenSize.height * 0.02),
          _buildDescriptionAndColors(),
          SizedBox(height: screenSize.height * 0.01),
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
              fontSize: screenSize.width * 0.045,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          "\$${productPrice} USD",
          style: Styles.textStyle14pr.copyWith(
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
          "Descriptions",
          style: Styles.textStyle14pr.copyWith(
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
                    color: Colors.black,
                    width: 1.5,
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
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: productDescription.isNotEmpty
                ? productDescription
                : "This is a premium quality product, crafted with excellence and attention to detail. Perfect for your needs. ",
            style: Styles.textStyle14c7.copyWith(
              fontSize: screenSize.width * 0.035,
            ),
          ),
          TextSpan(
            text: "Read more",
            style: Styles.textStyle14info.copyWith(
              fontSize: screenSize.width * 0.035,
            ),
            // Implement "Read more" action here
          ),
        ],
      ),
    );
  }
}
