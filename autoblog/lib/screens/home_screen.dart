// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../widgets/post_card.dart';
import 'create_post_screen.dart';
import 'edit_post_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> futurePosts;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    setState(() {
      futurePosts = apiService.fetchPosts();
    });
  }

  Future<void> _deletePost(String id) async {
    try {
      await apiService.deletePost(id);
      _loadPosts(); // Recarrega a lista de posts
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post deletado com sucesso.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao deletar post.')),
      );
    }
  }

  void _confirmDelete(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Excluir Post'),
        content: Text('Tem certeza que deseja excluir este post?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Excluir'),
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
              _deletePost(post.id); // Deleta o post
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return PostCard(
                  post: posts[index],
                  onEdit: () async {
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
                  onDelete: () => _confirmDelete(posts[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
