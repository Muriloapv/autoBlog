// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../widgets/post_card.dart';
import 'create_post_screen.dart';
import 'edit_post_screen.dart';
import 'delete_post_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    setState(() {
      futurePosts = ApiService().fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Autoblog')),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum post disponível.'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    // Navega para a tela de edição do post
                    final updatedPost = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditPostScreen(post: posts[index]),
                      ),
                    );

                    if (updatedPost != null) {
                      _loadPosts(); // Recarrega os posts após edição
                    }
                  },
                  onLongPress: () async {
                    // Navega para a tela de confirmação de deleção do post
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeletePostScreen(post: posts[index]),
                      ),
                    );

                    if (result == true) {
                      _loadPosts(); // Recarrega os posts após exclusão
                    }
                  },
                  child: PostCard(post: posts[index]),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navega para a tela de criação de post
          final newPost = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );

          if (newPost != null) {
            _loadPosts(); // Recarrega os posts após criação
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
