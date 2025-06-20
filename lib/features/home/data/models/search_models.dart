class SearchUser {
  final String userId;
  final String name;
  final String? profileImage;

  SearchUser({
    required this.userId,
    required this.name,
    this.profileImage,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) {
    return SearchUser(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profileImage'],
    );
  }
}

class SearchHistoryItem {
  final String id;
  final String userId;
  final String query;
  final String type;
  final DateTime createdAt;

  SearchHistoryItem({
    required this.id,
    required this.userId,
    required this.query,
    required this.type,
    required this.createdAt,
  });

  factory SearchHistoryItem.fromJson(Map<String, dynamic> json) {
    return SearchHistoryItem(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      query: json['query'] ?? '',
      type: json['type'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
} 