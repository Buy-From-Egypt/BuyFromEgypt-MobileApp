import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:dio/dio.dart';
import 'package:buy_from_egypt/core/utils/secure_storage.dart';

class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });
}

class ProductService {
  static const String baseUrl = 'https://buy-from-egypt.vercel.app';
  static final Dio _dio = Dio();

  static Future<PaginatedResponse<Product>> getAllProducts({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final token = await SecureStorage.getToken();
      final response = await _dio.get(
        '$baseUrl/products',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print('getAllProducts - Response Status Code: ${response.statusCode}');
      print('getAllProducts - Response Body: ${response.data}');

      if (response.statusCode == 200) {
        final decodedBody = response.data;
        final List<dynamic> productsList = decodedBody['data'];
        final Map<String, dynamic> meta = decodedBody['meta'];
        
        return PaginatedResponse(
          data: productsList.map((productJson) => Product.fromJson(productJson)).toList(),
          currentPage: meta['page'] ?? page,
          totalPages: meta['totalPages'] ?? 1,
          totalItems: meta['total'] ?? productsList.length,
          hasNextPage: meta['NextPage'] ?? false,
          hasPreviousPage: meta['PreviousPage'] ?? false,
        );
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('getAllProducts - Error: $e');
      throw Exception('Failed to load products: $e');
    }
  }

  static Future<Product> getProductById(String productId) async {
    try {
      final token = await SecureStorage.getToken();
      final response = await _dio.get(
        '$baseUrl/products/$productId',
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> productData = response.data;
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

  static Future<PaginatedResponse<Product>> getAllProductsByFilter({
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    String? sortOrder,
    bool? available,
    String? currencyCode,
    bool? active,
    int? page,
    int? limit,
    int? minRating,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;
      if (sortBy != null) queryParams['sortBy'] = sortBy;
      if (sortOrder != null) queryParams['sortOrder'] = sortOrder;
      if (available != null) queryParams['available'] = available;
      if (currencyCode != null) queryParams['currencyCode'] = currencyCode;
      if (active != null) queryParams['active'] = active;
      if (page != null) queryParams['page'] = page;
      if (limit != null) queryParams['limit'] = limit;
      if (minRating != null) queryParams['minRating'] = minRating;

      // Retrieve token from SecureStorage
      final token = await SecureStorage.getToken();

      final response = await _dio.get(
        '$baseUrl/products',
        queryParameters: queryParams,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final decodedBody = response.data;
        final List<dynamic> productsList = decodedBody['data'];
        final Map<String, dynamic> meta = decodedBody['meta'];
        return PaginatedResponse(
          data: productsList.map((productJson) => Product.fromJson(productJson)).toList(),
          currentPage: meta['page'] ?? page,
          totalPages: meta['totalPages'] ?? 1,
          totalItems: meta['total'] ?? productsList.length,
          hasNextPage: meta['NextPage'] ?? false,
          hasPreviousPage: meta['PreviousPage'] ?? false,
        );
      } else {
        throw Exception('Failed to load filtered products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load filtered products: $e');
    }
  }

  static Future<List<CategoryWithCount>> getCategoriesWithProductCount() async {
    try {
      final response = await _dio.get('$baseUrl/products/categories-with-count');
      if (response.statusCode == 200) {
        final List<dynamic> categoriesList = response.data;
        return categoriesList
            .map((categoryJson) => CategoryWithCount.fromJson(categoryJson))
            .toList();
      } else {
        throw Exception('Failed to load categories with count: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories with count: $e');
    }
  }

  static Future<ProductRating> getProductRating(String productId) async {
    try {
      final token = await SecureStorage.getToken();
      final response = await _dio.get(
        '$baseUrl/rating/product/$productId',
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return ProductRating.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch product rating: \\${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch product rating: $e');
    }
  }

  static Future<ProductRating> rateProduct({
    required String productId,
    required int value,
    required String comment,
  }) async {
    try {
      final token = await SecureStorage.getToken();
      print('Sending review: rating=$value, comment=$comment, productId=$productId');
      final response = await _dio.post(
        '$baseUrl/rating/product/$productId',
        data: {
          'value': value,
          'comment': comment,
        },
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ProductRating.fromJson(response.data);
      } else {
        throw Exception('Failed to rate product: \\${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to rate product: $e');
    }
  }

  static Future<List<ProductRating>> getAllProductReviews(String productId) async {
    try {
      final token = await SecureStorage.getToken();
      final response = await _dio.get(
        '$baseUrl/rating/product/$productId/all',
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductRating.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch product reviews: \\${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch product reviews: $e');
    }
  }
}

class CategoryWithCount {
  final String categoryId;
  final String name;
  final int productCount;

  CategoryWithCount({
    required this.categoryId,
    required this.name,
    required this.productCount,
  });

  factory CategoryWithCount.fromJson(Map<String, dynamic> json) {
    return CategoryWithCount(
      categoryId: json['categoryId'],
      name: json['name'],
      productCount: json['productCount'],
    );
  }
}

class ProductRating {
  final String message;
  final int userRating;
  final int totalReviews;
  final String comment;
  final String? userName;
  final String? userProfileImage;
  final DateTime? createdAt;

  ProductRating({
    required this.message,
    required this.userRating,
    required this.totalReviews,
    required this.comment,
    this.userName,
    this.userProfileImage,
    this.createdAt,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) {
    return ProductRating(
      message: json['message'] ?? '',
      userRating: json['userRating'] ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
      comment: json['comment'] ?? '',
      userName: json['user'] != null ? json['user']['name'] : null,
      userProfileImage: json['user'] != null ? json['user']['profileImage'] : null,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
    );
  }
}
