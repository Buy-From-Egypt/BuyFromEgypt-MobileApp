import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/saved_products_service.dart';

class OrderButton extends StatefulWidget {
  final String productId;
  final VoidCallback? onSavedProductsUpdated;

  const OrderButton({
    super.key,
    required this.productId,
    this.onSavedProductsUpdated,
  });

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isSaved = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSavedStatus();
  }

  Future<void> _checkSavedStatus() async {
    try {
      final isSaved = await SavedProductsService.isProductSaved(widget.productId);
      if (mounted) {
        setState(() {
          _isSaved = isSaved;
        });
      }
    } catch (e) {
      print('Error checking saved status: $e');
    }
  }

  Future<void> _toggleSave() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isSaved) {
        await SavedProductsService.unsaveProduct(widget.productId);
      } else {
        await SavedProductsService.saveProduct(widget.productId);
      }

      if (mounted) {
        setState(() {
          _isSaved = !_isSaved;
        });
        widget.onSavedProductsUpdated?.call();
      }
    } catch (e) {
      print('Error toggling save status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isSaved ? 'Failed to unsave product' : 'Failed to save product'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          SizedBox(
            height: 52,
            width: 260,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: EdgeInsets.zero, 
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Request Order',
                      style: Styles.textStyle16c7
                          .copyWith(color: AppColors.newBeige),
                    ),
                    SvgIcon(
                      path: 'assets/images/edit.svg',
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isSaved ? AppColors.primary : AppColors.primary,
                width: 1,
              ),
            ),
            child: Center(
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        _isSaved ? SolarIconsBold.bookmark : SolarIconsOutline.bookmark,
                        color: _isSaved ? AppColors.primary : AppColors.primary,
                      ),
                      onPressed: _toggleSave,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
