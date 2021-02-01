import 'package:flutter_tutorial/models/post.dart' show Post;

class PostsProvider {
  final List<Post> _savedList;

  PostsProvider() : this._savedList = [];

  /// Is [post] already added to [_savedList].
  bool has(Post post) => this._savedList.any((p) => p.uuid == post.uuid);

  /// Add [post] to [_savedList].
  void save(post) => this._savedList.add(post);

  /// Removes [post] from [_savedList].
  void removedSaved(Post post) => this._savedList.remove(post);

  /// Toggle [post] save status.
  bool toggle(Post post) {
    if (this.has(post)) {
      this.removedSaved(post);
      return false;
    } else {
      this.save(post);
      return true;
    }
  }

  /// Get [post] at [index].
  Post at(int index) => this._savedList.elementAt(index);

  int get length => this._savedList.length;
}
