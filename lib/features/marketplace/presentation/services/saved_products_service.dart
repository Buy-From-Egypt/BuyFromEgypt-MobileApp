import 'package:buy_from_egypt/features/marketplace/presentation/data/product_model.dart';
import 'package:buy_from_egypt/features/marketplace/presentation/services/api_service.dart';
import 'package:dio/dio.dart';

class SavedProductsService {
  static Future<void> saveProduct(String productId) async {
    try {
      print('Attempting to save product $productId');
      final response = await MarketplaceApiService.request(
        endpoint: '/products/$productId/save',
        method: 'POST',
        body: {}, 
      );
      print('Save product response: ${response.statusCode}');
      print('Save product response data: ${response.data}');
    } catch (e) {
      print('Error saving product: $e');
      throw Exception('Failed to save product: $e');
    }
  }

  static Future<void> unsaveProduct(String productId) async {
    try {
      print('Attempting to unsave product $productId');
      final response = await MarketplaceApiService.request(
        endpoint: '/products/$productId/save',
        method: 'DELETE',
      );
      print('Unsave product response: ${response.statusCode}');
      print('Unsave product response data: ${response.data}');
    } catch (e) {
      print('Error unsaving product: $e');
      throw Exception('Failed to unsave product: $e');
    }
  }

  static Future<List<Product>> getSavedProducts() async {
    try {
      print('Attempting to fetch saved products');
      final response = await MarketplaceApiService.request(
        endpoint: '/products/saved',
        method: 'GET',
      );
      print('Get saved products response: ${response.statusCode}');
      print('Get saved products response data: ${response.data}');

      final data = response.data as List;
      print('Found ${data.length} saved products');

      // Fetch complete product data for each saved product
      List<Product> completeProducts = [];
      for (var item in data) {
        try {
          final productId = item['productId'];
          print('Fetching complete data for product: $productId');
          
          final productResponse = await MarketplaceApiService.request(
            endpoint: '/products/$productId',
            method: 'GET',
          );
          
          if (productResponse.statusCode == 200) {
            final productData = productResponse.data;
            completeProducts.add(Product.fromJson(productData));
          } else {
            print('Failed to fetch complete data for product $productId');
            completeProducts.add(Product.fromJson(item));
          }
        } catch (e) {
          print('Error fetching complete data for product: $e');
          completeProducts.add(Product.fromJson(item));
        }
      }
      
      return completeProducts;
    } catch (e) {
      print('Error fetching saved products: $e');
      throw Exception('Failed to fetch saved products: $e');
    }
  }

  static Future<bool> isProductSaved(String productId) async {
    try {
      print('Checking if product $productId is saved');
      final saved = await getSavedProducts();
      final isSaved = saved.any((product) => product.productId == productId);
      print('Product $productId is ${isSaved ? 'saved' : 'not saved'}');
      return isSaved;
    } catch (e) {
      print('Error checking saved status: $e');
      throw Exception('Check failed: $e');
    }
  }
}
