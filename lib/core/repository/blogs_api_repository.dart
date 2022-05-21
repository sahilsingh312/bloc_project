import 'package:bloc_project/core/models/blog_post_model.dart';
import 'package:bloc_project/core/services/blogs_api_provider.dart';

class BLogsApiRepository {
  final _provider = BlogsApiProvider();

  Future<List<BlogPostModel>> fetchblogPosts() {
    return _provider.fetchblogPosts();
  }
}

class NetworkError extends Error {}
