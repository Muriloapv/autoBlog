import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  final ApiService apiService = ApiService(); // Instância do serviço de API

  void _createPost() async {
    final newPost = Post(
      id: '', // O ID pode ser gerado automaticamente no backend
      titulo: _tituloController.text,
      img: _imgController.text,
      descricao: _descricaoController.text,
      dataDePostagem: DateTime.now().toString(),
    );

    try {
      await apiService.createPost(newPost);
      print('Novo post criado com sucesso');
      Navigator.pop(
          context, newPost); // Retorna o novo post para a tela anterior
    } catch (e) {
      print('Erro ao criar post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar post. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Criar Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              controller: _imgController,
              decoration: InputDecoration(labelText: "Link da Imagem"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPost,
              child: Text("Criar Post"),
            ),
          ],
        ),
      ),
    );
  }
}
