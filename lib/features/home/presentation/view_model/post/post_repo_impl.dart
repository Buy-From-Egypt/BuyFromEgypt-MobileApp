import 'package:buy_from_egypt/features/home/presentation/view_model/post/model/post_model.dart';
import 'package:buy_from_egypt/features/home/presentation/view_model/post/post_repo.dart';
import 'package:buy_from_egypt/services/api_service.dart';

class PostRepoImpl implements PostRepo {
  @override
  Future<List<PostModel>> getPosts() async {
    final response = await ApiService.request(
      endpoint: '/posts/',
      method: 'GET',
    );

    final data = ApiService.handleResponse(response);
    return (data as List).map((json) => PostModel.fromJson(json)).toList();
  }

  @override
  Future<PostModel> createPost(PostModel post) async {
    final response = await ApiService.request(
      // Send a POST request to the '/posts/' endpoint with the post data.
      endpoint: '/posts/',
      method: 'POST',
      body: post.toJson(),
      useAuth: true,
    );

    final data = ApiService.handleResponse(response);
    // Handle the server response and parse the JSON into a PostModel.
    return PostModel.fromJson(data);
  }
}
