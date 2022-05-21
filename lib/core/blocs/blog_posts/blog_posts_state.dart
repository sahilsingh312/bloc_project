part of 'blog_posts_bloc.dart';

abstract class BlogPostsState extends Equatable {
  const BlogPostsState();

  @override
  List<Object> get props => [];
}

class BlogPostsInitial extends BlogPostsState {}

class BlogPostsLoading extends BlogPostsState {}

class BlogPostsLoaded extends BlogPostsState {
  final List<BlogPostModel> blogPostModels;
  const BlogPostsLoaded({
    required this.blogPostModels,
  });
}

class BlogPostsError extends BlogPostsState {
  final String? message;
  const BlogPostsError(this.message);
}
