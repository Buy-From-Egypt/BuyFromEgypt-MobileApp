import 'package:buy_from_egypt/features/marketplace/presentation/widgets/app_bar.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/industury_section.dart';
import 'package:flutter/material.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/drop_down_row.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/toggle_row.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/product_service.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/core/utils/app_colors.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CAppBar(title: 'Filter',),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: FilterContent(),
        ),
      ),
    );
  }
}

class FilterContent extends StatefulWidget {
  const FilterContent({super.key});

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  List<CategoryWithCount> _categories = [];
  bool _isLoadingCategories = true;
  String? _selectedCategoryId;
  double? _minPrice;
  double? _maxPrice;
  bool _freeShipping = false;
  bool _inStockOnly = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await ProductService.getCategoriesWithProductCount();
      setState(() {
        _categories = categories;
        _isLoadingCategories = false;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _isLoadingCategories
              ? const CircularProgressIndicator(
                  color: AppColors.primary,
                )
              : IndustrySection(
                  categories: _categories,
                  onCategorySelected: (categoryId) {
                    setState(() {
                      _selectedCategoryId = categoryId;
                    });
                  },
                  isLoading: _isLoadingCategories,
                ),
          const SizedBox(height: 24),
          ToggleRow(
            title: 'Free shipping',
            onToggle: (value) {
              setState(() {
                _freeShipping = value;
              });
            },
          ),
          const SizedBox(height: 24),
          ToggleRow(
            title: 'In-Stock only',
            onToggle: (value) {
              setState(() {
                _inStockOnly = value;
              });
            },
          ),
          const SizedBox(height: 24),
          DropdownRow(
            title: 'Price',
            onPriceRangeSelected: (min, max) {
              setState(() {
                _minPrice = min;
                _maxPrice = max;
              });
            },
          ),
          const SizedBox(height: 24),
          const DropdownRow(title: 'Ratings'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              // TODO: Implement apply filter logic
              print('Selected Category ID: $_selectedCategoryId');
              print('Min Price: $_minPrice, Max Price: $_maxPrice');
              print('Free Shipping: $_freeShipping');
              print('In-Stock Only: $_inStockOnly');
              try {
                final products = await ProductService.getAllProductsByFilter(
                  categoryId: _selectedCategoryId,
                  minPrice: _minPrice,
                  maxPrice: _maxPrice,
                  available: _inStockOnly, // Assuming in-stock relates to available
                  // free shipping is not a direct backend filter, would need to be handled client-side or as a custom backend filter
                );
                print('Filtered products: ${products.length}');
                Navigator.pop(context, products);
              } catch (e) {
                print('Error applying filters: $e');
              }
            },
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}


