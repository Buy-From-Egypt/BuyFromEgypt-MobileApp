class PostModel {
  final String postId;
  final String title;
  final String content;
  final String? userId;
  final String? cloudFolder;
  final String? createdAt;
  final String? updatedAt;

  PostModel({
    required this.postId,
    required this.title,
    required this.content,
    this.userId,
    this.cloudFolder,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      userId: json['userId'],
      cloudFolder: json['cloudFolder'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "title": title,
      "content": content,
    };

    if (cloudFolder != null && cloudFolder!.isNotEmpty) {
      data["cloudFolder"] = cloudFolder!;
    }

    return data;
  }
}
