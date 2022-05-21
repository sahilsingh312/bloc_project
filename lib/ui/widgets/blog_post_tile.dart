import 'package:flutter/material.dart';

class BlogPostTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const BlogPostTile({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(title),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
