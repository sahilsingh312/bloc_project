part of 'blog_posts_bloc.dart';

abstract class BlogPostsEvent extends Equatable {
  const BlogPostsEvent();

  @override
  List<Object> get props => [];
}

class GetBlogsList extends BlogPostsEvent {}
