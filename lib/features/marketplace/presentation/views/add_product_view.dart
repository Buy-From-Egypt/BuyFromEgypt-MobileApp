import 'dart:io';

import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button.dart';
import 'package:buy_from_egypt/features/auth/presentation/widgets/custom_button_with_border.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/product_service.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/app_bar.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/custom_input.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _currencyCodeController = TextEditingController();
  final _categoryIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
    setState(() {
        _image = File(image.path);
      });
      }
  }

  Future<void> _createProduct() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _currencyCodeController.text.isEmpty ||
        _categoryIdController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? categoryId = await ProductService.getCategoryIdByName(_categoryIdController.text);

      if (categoryId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category not found. Please enter a valid category name.')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      await ProductService.createProduct(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        currencyCode: _currencyCodeController.text,
        categoryId: categoryId,
        available: true,
        image: _image,
      );
      
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product created successfully!')),
      );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create product: $e')),
      );
      }
    } finally {
      if (mounted) {
      setState(() {
        _isLoading = false;
      });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _currencyCodeController.dispose();
    _categoryIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CAppBar(title: 'Add Product'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomInput(
              label: 'Product Name',
              hint: 'Enter your product name',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              label: 'Product Price',
              hint: 'Enter your product price',
              controller: _priceController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            CustomInput(
              label: 'Currency Code',
              hint: 'Enter currency code (e.g., EGP, USD)',
              controller: _currencyCodeController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              label: 'Category name',
              hint: 'Enter category Name',
              controller: _categoryIdController,
            ),
            const SizedBox(height: 16),
            CustomInput(
              label: 'Description',
              hint: 'Describe your product',
              maxLines: 3,
              controller: _descriptionController,
            ),
            const SizedBox(height: 24),
            CustomOutlinedButton(
              label: _image == null ? 'Upload Image' : 'Image Selected',
              icon: Icon(
                _image == null ? FontAwesomeIcons.arrowUpFromBracket : Icons.check,
                size: 16,
                color: AppColors.primary,
              ),
              onPressed: _pickImage,
            ),
            if (_image != null) ...[
              const SizedBox(height: 16),
              Image.file(_image!, height: 100),
            ],
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                  onPressed: _isLoading ? null : _createProduct,
                  text: 'Done',
                  isLoading: _isLoading),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomButtonWithBorder(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Cancel',
                isLoading: false,
              ),
            ),
              const SizedBox(height: 24),
          ],
          ),
        ),
      ),
    );
  }
}
