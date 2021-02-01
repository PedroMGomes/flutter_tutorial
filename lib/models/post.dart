import 'package:faker/faker.dart' show faker;
import 'package:uuid/uuid.dart';

const _randomKeywordList = ['blue', 'brown', 'green', 'red', 'yellow'];

/// [Post].
class Post {
  final String uuid;

  /// [user].
  final String user;

  /// [image] URL.
  final String image;

  final String description;

  final String keyword;

  /// [Post].
  Post(this.uuid, this.user, this.image, this.description, this.keyword);

  /// Fake Post.
  factory Post.fake() {
    final uuid = Uuid().v4();
    final user = faker.person.name();
    final description = faker.lorem.sentence();
    // Get a random keyword from the _randomKeywordList.
    final keyword = _randomKeywordList.elementAt(
        faker.randomGenerator.integer(_randomKeywordList.length, min: 0));
    final image = 'https://source.unsplash.com/random/?$keyword';
    return Post(uuid, user, image, description, keyword);
  }
}
