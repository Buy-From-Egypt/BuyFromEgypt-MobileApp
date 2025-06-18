// lib/features/home/presentation/view_model/post/post_repo.dart

import 'model/post_model.dart';

abstract class PostRepo {
  Future<List<PostModel>> getPosts();
  Future<PostModel> createPost(PostModel post);
}
