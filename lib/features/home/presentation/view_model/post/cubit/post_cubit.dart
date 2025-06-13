import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';

class PostCubit extends Cubit<List<PostModel>> {
  PostCubit() : super([]);

  final Dio dio = Dio();

  Future<void> fetchPosts() async {
    try {
      final response =
          await dio.get('https://buy-from-egypt.vercel.app/posts/');
      final posts = (response.data as List)
          .map((json) => PostModel.fromJson(json))
          .toList();

      emit(posts);
    } catch (e) {
      print("❌ Error fetching posts: $e");
    }
  }

  void addPostModel(PostModel post) {
    emit([post, ...state]);
  }
}
