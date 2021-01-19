import 'package:flutter/material.dart';
import 'package:infinite_scroll/models/post.dart' show Post;

/// [PostWidget].
class PostWidget extends StatelessWidget {
  const PostWidget({Key key, @required this.post}) : super(key: key);

  final Post post;

  /// build.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(Icons.verified, color: Colors.blue),
                const SizedBox(width: 8.0),
                Text(post.user, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Image.network(
            this.post.image,
            height: 300,
            fit: BoxFit.contain,
            errorBuilder: (context, err, stackTrace) => Container(
              height: 300,
              width: double.infinity,
              color: Colors.blueGrey,
              child: const Text('Failed to load image.'),
            ),
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              // Same as the example provided in the official docs.
              if (wasSynchronouslyLoaded) {
                return child;
              } else {
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                );
              }
            },
          ),
          const SizedBox(height: 8.0),
          Text(this.post.description),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.bookmark_border, color: Colors.green),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.blue),
                  onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
