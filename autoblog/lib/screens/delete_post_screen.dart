import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class DeletePostScreen extends StatelessWidget {
  final Post post;

  DeletePostScreen({required this.post});

  void _deletePost(BuildContext context) async {
    await ApiService().deletePost(post.id);
    Navigator.pop(
        context, true); // Retorna true para indicar que o post foi deletado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deletar Post')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tem certeza de que deseja deletar o post "${post.titulo}"?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _deletePost(context),
                  child: Text('Sim'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context, false), // Volta sem deletar
                  child: Text('Não'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
