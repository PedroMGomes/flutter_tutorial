import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/home_page.dart' show HomePage;
import 'package:flutter_tutorial/pages/saved_posts_page.dart'
    show SavedPostsPage;

/// [DrawerWidget].
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  /// build.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 96,
            child: DrawerHeader(
              child: Text('Flutter Tutorial',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white)),
              decoration: BoxDecoration(color: Colors.blue),
            ),
          ),
          ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home, color: Colors.blue),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => HomePage()))),
          const Divider(),
          ListTile(
            title: const Text('Saved Posts'),
            leading: const Icon(Icons.bookmark, color: Colors.green),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SavedPostsPage())),
          ),
          const Divider(),
          ListTile(
            title: const Text('Close'),
            leading: const Icon(Icons.power_settings_new, color: Colors.grey),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
