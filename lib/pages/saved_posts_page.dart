import 'package:flutter/material.dart';
import 'package:flutter_tutorial/widgets/drawer_widget.dart' show DrawerWidget;
import 'package:flutter_tutorial/widgets/saved_posts_grid.dart'
    show SavedPostsGrid;

/// [SavedPostsPage].
class SavedPostsPage extends StatelessWidget {
  const SavedPostsPage({Key key}) : super(key: key);

  /// build.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: SavedPostsGrid(),
      ),
    );
  }
}
