import 'package:bloc/bloc.dart';
import 'package:bloc_project/core/models/blog_post_model.dart';
import 'package:bloc_project/core/services/blogs_api_provider.dart';
import 'package:equatable/equatable.dart';

import '../../repository/blogs_api_repository.dart';

part 'blog_posts_event.dart';
part 'blog_posts_state.dart';

class BlogPostsBloc extends Bloc<BlogPostsEvent, BlogPostsState> {
  final BlogsApiProvider blogsApiProvider = BlogsApiProvider();
  BlogPostsBloc({required BlogsApiProvider blogsApiProvider})
      : super(BlogPostsInitial()) {
    on<GetBlogsList>((event, emit) async {
      try {
        emit(BlogPostsLoading());
        final myList = await blogsApiProvider.fetchblogPosts();
        emit(BlogPostsLoaded(blogPostModels: myList));
      } on NetworkError {
        emit(const BlogPostsError(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
