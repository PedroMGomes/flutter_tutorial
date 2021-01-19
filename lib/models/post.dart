import 'package:faker/faker.dart' show faker;

const _randomKeywordList = ['blue', 'brown', 'green', 'red', 'yellow'];

/// [Post].
class Post {
  /// [user].
  final String user;

  /// [image] URL.
  final String image;

  final String description;

  /// [Post].
  const Post(this.user, this.image, this.description);

  /// Fake Post.
  factory Post.fake() {
    final user = faker.person.name();
    final keyword = _randomKeywordList.elementAt(
        faker.randomGenerator.integer(_randomKeywordList.length, min: 0));
    final image = 'https://source.unsplash.com/random/?$keyword';
    final description = faker.lorem.sentence();
    return Post(user, image, description);
  }
}
