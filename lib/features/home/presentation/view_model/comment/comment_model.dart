class CommentModel {
  final String id;
  final String contant;
  final String userName;
  final DateTime createdAt;
  int rating;
  int likes;
  int dislikes;
  bool isLiked;
  bool isDisliked;
  bool isRated;
  List<CommentModel> replies;

  CommentModel({
    required this.id,
    required this.contant,
    required this.userName,
    required this.createdAt,
    required this.rating,
    required this.likes,
    required this.dislikes,
    required this.isLiked,
    required this.isDisliked,
    required this.isRated,
    this.replies = const [],
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      contant: json['contant'],
      userName: json['userName'],
      createdAt: DateTime.parse(json['createdAt']),
      rating: json['rating'] ?? 0,
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      isDisliked: json['isDisliked'] ?? false,
      isRated: json['isRated'] ?? false,
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contant': contant,
      'userName': userName,
      'createdAt': createdAt.toIso8601String(),
      'rating': rating,
      'likes': likes,
      'dislikes': dislikes,
      'isLiked': isLiked,
      'isDisliked': isDisliked,
      'isRated': isRated,
      'replies': replies.map((e) => e.toJson()).toList(),
    };
  }
}
