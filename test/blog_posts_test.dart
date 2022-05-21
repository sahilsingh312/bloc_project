import 'package:bloc_project/core/blocs/blog_posts/blog_posts_bloc.dart';
import 'package:bloc_project/core/models/blog_post_model.dart';
import 'package:bloc_project/core/services/blogs_api_provider.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'blog_posts_test.mocks.dart';

@GenerateMocks([BlogsApiProvider])
var mockBlogsApiProvider = MockBlogsApiProvider();
Future<void> main() async {
  group('Blog Posts Bloc', () {
    blocTest(
      'Checking for Api call',
      build: () {
        when(mockBlogsApiProvider.fetchblogPosts())
            .thenAnswer((_) async => <BlogPostModel>[]);
        final bloc = BlogPostsBloc(blogsApiProvider: mockBlogsApiProvider);
        bloc.add(GetBlogsList());
        return bloc;
      },
      expect: () => [
        BlogPostsLoading(),
        BlogPostsLoaded(blogPostModels: [
          BlogPostModel(userId: 1, id: 1, title: 'title1', body: 'body1'),
          BlogPostModel(userId: 1, id: 2, title: 'title2', body: 'body2')
        ]),
      ],
      setUp: () {},
    );
  });
}
