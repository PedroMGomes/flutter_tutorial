import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tutorial/providers/posts_provider.dart'
    show PostsProvider;

class SavedPostsGrid extends StatelessWidget {
  const SavedPostsGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (_, provider, __) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: provider.length,
        itemBuilder: (context, index) =>
            Image.network(provider.at(index).image),
      ),
    );
  }
}
