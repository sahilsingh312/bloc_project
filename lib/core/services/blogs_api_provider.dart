import 'package:bloc_project/core/models/blog_post_model.dart';
import 'package:dio/dio.dart';

class BlogsApiProvider {
  final Dio _dio = Dio();
  final String _url = 'http://jsonplaceholder.typicode.com/posts';

  Future<List<BlogPostModel>> fetchblogPosts() async {
    try {
      Response response = await _dio.get(_url);
      return (response.data as List)
          .map((e) => BlogPostModel.fromJson(e))
          .toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
