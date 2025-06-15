import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:dio/dio.dart';

class ProductService {
  static const String baseUrl = 'https://buy-from-egypt.vercel.app';
  static final Dio _dio = Dio();

  static Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        final List<dynamic> productsList = decodedBody['data'];
        return productsList
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  static Future<Product> getProductById(String productId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products/$productId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> productData = json.decode(response.body);
        return Product.fromJson(productData);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  static Future<List<Category>> getAllCategories() async {
    try {
      final response = await _dio
          .get('$baseUrl/category'); // Assuming /category is the endpoint
      if (response.statusCode == 200) {
        final List<dynamic> categoriesList = response.data;
        return categoriesList
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  static Future<String?> getCategoryIdByName(String categoryName) async {
    try {
      final List<Category> categories = await getAllCategories();
      final category = categories.firstWhere(
        (cat) => cat.name.toLowerCase() == categoryName.toLowerCase(),
        orElse: () => throw Exception('Category not found'),
      );
      return category.categoryId;
    } catch (e) {
      print('Error getting category ID by name: $e');
      return null;
    }
  }

  static Future<void> createProduct({
    required String name,
    required String description,
    required double price,
    required String currencyCode,
    required String categoryId,
    required bool available,
    File? image,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'description': description,
        'price': price,
        'currencyCode': currencyCode,
        'categoryId': categoryId,
        'available': available,
      });

      if (image != null) {
        formData.files.add(MapEntry(
          'images',
          await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last),
        ));
      }

      Response response = await _dio.post(
        '$baseUrl/products',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 201) {
        print('Product created: ${response.data}');
      } else {
        throw Exception(
            'Failed to create product: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }
}
