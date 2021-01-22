import 'package:flutter_tutorial/models/post.dart' show Post;

/// [PostServer].
/// Local backend.
class PostServer {
  static const _n = 100;
  static final List<Post> _postList =
      List.generate(_n, (index) => Post.fake(), growable: false);

  // static List<Post> getAll() => _postList;

  /// Pagination.
  /// [offset] - starting point.
  /// [limit] - number of total elements.
  /// [keywordFilter] - filter.
  static List<Post> get({
    int offset = 0,
    int limit = 20,
    String keywordFilter = '',
  }) {
    final arr = (keywordFilter.isEmpty)
        ? _postList
        : _postList
            .where((post) =>
                post.keyword.contains(keywordFilter.trim().toLowerCase()))
            .toList();
    final t = offset + limit;
    final end = (arr.length > t) ? t : arr.length;
    return arr.getRange(offset, end).toList();
  }
}
