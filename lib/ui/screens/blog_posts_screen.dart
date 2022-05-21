import 'package:bloc_project/core/blocs/blog_posts/blog_posts_bloc.dart';
import 'package:bloc_project/core/models/blog_post_model.dart';
import 'package:bloc_project/core/services/blogs_api_provider.dart';
import 'package:bloc_project/ui/widgets/blog_post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPostsScreen extends StatefulWidget {
  const BlogPostsScreen({Key? key}) : super(key: key);

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<BlogPostsScreen> {
  final BlogPostsBloc _blogPostBloc = BlogPostsBloc(blogsApiProvider: BlogsApiProvider());

  @override
  void initState() {
    _blogPostBloc.add(GetBlogsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blog Posts List')),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _blogPostBloc,
        child: BlocListener<BlogPostsBloc, BlogPostsState>(
          listener: (context, state) {
            if (state is BlogPostsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<BlogPostsBloc, BlogPostsState>(
            builder: (context, state) {
              if (state is BlogPostsInitial || state is BlogPostsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BlogPostsLoaded) {
                return _buildCard(context, state.blogPostModels);
              } else if (state is BlogPostsError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<BlogPostModel> model) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (BuildContext context, int index) {
        return BlogPostTile(
            title: model[index].title!, subtitle: model[index].body!);
      },
    );
  }
}
