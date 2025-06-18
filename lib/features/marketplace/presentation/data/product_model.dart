class Product {
  final String productId;
  final String name;
  final String slug;
  final String description;
  final double price;
  final String currencyCode;
  final bool active;
  final bool available;
  final double rating;
  final int reviewCount;
  final String cloudFolder;
  final String ownerId;
  final String categoryId;
  final String? approvedById;
  final DateTime? approvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> images;
  final Owner? owner;
  final Category? category;
  final String? userUserId;

  Product({
    required this.productId,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.currencyCode,
    required this.active,
    required this.available,
    required this.rating,
    required this.reviewCount,
    required this.cloudFolder,
    required this.ownerId,
    required this.categoryId,
    this.approvedById,
    this.approvedAt,
    required this.createdAt,
    required this.updatedAt,
    this.images = const [],
    this.owner,
    this.category,
    this.userUserId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      currencyCode: json['currencyCode'] ?? 'EGP',
      active: json['active'] ?? false,
      available: json['available'] ?? false,
      rating: (json['rating'] is num) ? (json['rating'] as num).toDouble() : 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      cloudFolder: json['cloudFolder'] ?? '',
      ownerId: json['ownerId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      approvedById: json['approvedById'],
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      images: json['images'] != null
          ? (json['images'] is List
              ? (json['images'] as List).map<String>((img) {
                  if (img is String) return img;
                  if (img is Map) {
                    if (img['url'] != null) return img['url'] as String;
                    if (img['imageUrl'] != null) return img['imageUrl'] as String;
                  }
                  return '';
                }).where((url) => url.isNotEmpty).toList()
              : [])
          : [],
      owner: json['owner'] != null
          ? Owner.fromJson(json['owner'])
          : null,
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      userUserId: json['userUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'currencyCode': currencyCode,
      'active': active,
      'available': available,
      'rating': rating,
      'reviewCount': reviewCount,
      'cloudFolder': cloudFolder,
      'ownerId': ownerId,
      'categoryId': categoryId,
      'approvedById': approvedById,
      'approvedAt': approvedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'images': images,
      'owner': owner?.toJson(),
      'category': category?.toJson(),
      'userUserId': userUserId,
    };
  }
}

class Owner {
  final String userId;
  final String name;
  final String email;
  final String role;

  Owner({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      userId: json['userId'] ?? '',
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}

class Category {
  final String categoryId;
  final String name;
  final String description;

  Category({
    required this.categoryId,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? 'Uncategorized',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      'description': description,
    };
  }
}
