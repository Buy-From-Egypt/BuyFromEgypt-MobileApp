// lib/features/home/presentation/view_model/post/cubit/create_post_cubit.dart

import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_post_state.dart';
import 'post_cubit.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostRepo postRepo;

  String? description;
  String? title;
  String? selectedImagePath;

  CreatePostCubit({required this.postRepo}) : super(CreatePostInitial());

  void onDescriptionChanged(String value) {
    description = value;
  }

  void onTitleChanged(String value) {
    title = value;
  }

  void onImageSelected(String? imagePath) {
    selectedImagePath = imagePath;
  }

  void resetForm() {
    description = null;
    title = null;
    selectedImagePath = null;
  }

  Future<PostModel?> submitPost(BuildContext context) async {
    if (description == null || description!.trim().isEmpty) {
      emit(CreatePostError("Post content cannot be empty."));
      return null;
    }

    emit(CreatePostLoading());

    try {
      final post = PostModel(
        postId: '',
        title: title ?? "Default Title",
        content: description!.trim(),
        cloudFolder: selectedImagePath != null
            ? "buyfromegypt/posts/${_generateFolderId()}"
            : null,
      );

      final createdPost = await postRepo.createPost(post);

      context.read<PostCubit>().addPostModel(createdPost);

      emit(CreatePostSuccess());

      resetForm(); // ✅ تنظيف الحقول بعد الإنشاء

      return createdPost;
    } catch (e) {
      emit(CreatePostError("Something went wrong: ${e.toString()}"));
      return null;
    }
  }

  String _generateFolderId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
