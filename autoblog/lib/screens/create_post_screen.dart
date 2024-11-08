import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class CreatePostScreen extends StatelessWidget {
  final _tituloController = TextEditingController();
  final _imgController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Post')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _imgController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Chamar método para salvar o novo post
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
