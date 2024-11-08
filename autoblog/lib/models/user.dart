import 'post.dart'; // Importa a classe Post

class User {
  final String id;
  final String name;
  final List<Post> posts;

  User({
    required this.id,
    required this.name,
    required this.posts,
  });
}
