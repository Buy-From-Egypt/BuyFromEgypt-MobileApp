import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/order_button.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/order_review.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/product_service.dart';

class ProductInfoSection extends StatefulWidget {
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
  final String productId;
  final VoidCallback? onSavedProductsUpdated;

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
    required this.productId,
    this.onSavedProductsUpdated,
  });

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {
  ProductRating? _rating;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchRating();
  }

  Future<void> _fetchRating() async {
    print('Fetching rating for product: \\${widget.productId}');
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final rating = await ProductService.getProductRating(widget.productId);
      print('Fetched rating: \\${rating.toString()}');
      setState(() {
        _rating = rating;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _showRatingDialog() async {
    int selectedRating = _rating?.userRating ?? 0;
    TextEditingController commentController = TextEditingController(text: _rating?.comment ?? '');
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rate this product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => IconButton(
                  icon: Icon(
                    index < selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                    // ignore: invalid_use_of_protected_member
                    (context as Element).markNeedsBuild();
                  },
                )),
              ),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(labelText: 'Comment'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedRating > 0) {
                  await ProductService.rateProduct(
                    productId: widget.productId,
                    value: selectedRating,
                    comment: commentController.text,
                  );
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      _fetchRating();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: widget.screenSize.width * 0.06,
        vertical: widget.screenSize.height * 0.02,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProductDetails(),
          const SizedBox(height: 16),
          SizedBox(height: widget.screenSize.height * 0.01),
          OrderButton(
            productId: widget.productId,
            onSavedProductsUpdated: widget.onSavedProductsUpdated,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OrderReviewSection(
              productId: widget.productId,
              onReviewSubmitted: _fetchRating,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    final showReadMore = widget.productDescription.length > 100 || widget.productDescription.split('\n').length > 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildNameAndPrice(),
        const SizedBox(height: 24),
        _buildDescriptionAndColors(),
        const SizedBox(height: 8),
        Text(
          widget.productDescription.isNotEmpty ? widget.productDescription : "No description available.",
          style: Styles.textStyle14c7.copyWith(
            color: AppColors.c16,
            fontSize: widget.screenSize.width * 0.035,
          ),
          maxLines: widget.isDescriptionExpanded ? null : 3,
          overflow: widget.isDescriptionExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (showReadMore)
          GestureDetector(
            onTap: widget.onReadMoreTap,
            child: Text(
              widget.isDescriptionExpanded ? "Show less" : "Read more",
              style: Styles.textStyle14info.copyWith(
                fontSize: widget.screenSize.width * 0.035,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNameAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.productName,
            style: Styles.textStyle166pr.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: widget.screenSize.width * 0.045,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          "${widget.productPrice} ${widget.currencyCode}",
          style: Styles.textStyle14.copyWith(
            color: AppColors.primary,
            fontSize: widget.screenSize.width * 0.04,
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
            fontSize: widget.screenSize.width * 0.04,
          ),
        ),
        Row(
          children: List.generate(
            widget.availableColors.length,
            (index) => GestureDetector(
              onTap: () => widget.onColorSelected(index),
              child: Container(
                margin: EdgeInsets.only(left: widget.screenSize.width * 0.02),
                width: widget.screenSize.width * 0.035,
                height: widget.screenSize.width * 0.035,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.availableColors[index],
                  border: Border.all(
                    color: widget.selectedColorIndex == index ? AppColors.primary : Colors.transparent,
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
}