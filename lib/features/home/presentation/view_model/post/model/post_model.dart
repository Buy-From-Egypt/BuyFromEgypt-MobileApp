class PostModel {
  final String postId;
  final String title;
  final String content;
  final String? userId;
  final String? cloudFolder;
  final String? createdAt;

  PostModel({
    required this.postId,
    required this.title,
    required this.content,
    this.userId,
    this.cloudFolder,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      userId: json['userId'],
      cloudFolder: json['cloudFolder'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      // ما تبعتيش postId ولا createdAt في POST
    };
  }
}
