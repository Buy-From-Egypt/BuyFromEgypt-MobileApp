import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'create_post_state.dart';
import 'post_cubit.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInitial());

  String? description;
  String? title;

  final Dio dio = Dio();

  void onDescriptionChanged(String value) {
    description = value;
  }

  void onTitleChanged(String value) {
    title = value;
  }

  Future<void> submitPost(BuildContext context) async {
    if (description == null || description!.trim().isEmpty) {
      emit(CreatePostError("Post content cannot be empty."));
      return;
    }

    emit(CreatePostLoading());

    try {
      final token = await _getToken(); // Replace with actual token logic

      final response = await dio.post(
        'https://buy-from-egypt.vercel.app/posts/',
        data: {
          "title": "Default Title", // ❗️تقدري تدخلي title من UI لو حبيتي
          "content": description!.trim(),
          "cloudFolder": "buyfromegypt/posts/${_generateFolderId()}",
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      final post = PostModel.fromJson(response.data);
      context.read<PostCubit>().addPostModel(post);

      emit(CreatePostSuccess());
    } catch (e) {
      emit(CreatePostError("Something went wrong, try again."));
    }
  }

  Future<String> _getToken() async {
    // ❗️ هنا هتجيبي التوكن من SharedPreferences أو secure storage
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjZjZlZGY5NC05ZWYyLTQ1MzQtYjU1NS1jNWYyN2ZjN2ZlYmEiLCJlbWFpbCI6ImFiZGVscmFobWFuLmFkZWwwNjNAZ21haWwuY29tIiwiYWN0aXZlIjp0cnVlLCJyb2xlIjoiQURNSU4iLCJ0eXBlIjoiRVhQT1JURVIiLCJpYXQiOjE3NDk3NzE0MjMsImV4cCI6MTc0OTc3NTAyM30.wM2GH_keuPDEEUO691hz-lElmakmgYuREECGvLs6EUE";
  }

  String _generateFolderId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
