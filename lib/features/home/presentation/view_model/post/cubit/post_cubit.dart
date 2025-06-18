import 'package:buy_from_egypt/features/home/presentation/view_model/post/post_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';

class PostCubit extends Cubit<List<PostModel>> {
  final PostRepo postRepo;

  PostCubit({required this.postRepo}) : super([]);

  Future<void> fetchPosts() async {
    try {
      final posts = await postRepo.getPosts();
      emit(posts.reversed.toList()); // ✅ نخلي الأحدث يطلع فوق
    } catch (e) {
      print("❌ Error fetching posts: $e");
      emit([]);
    }
  }

  // ✅ لإضافة بوست جديد في أول القائمة
  void addPostModel(PostModel post) {
    emit([post, ...state]);
  }
}
