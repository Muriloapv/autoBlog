import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class EditPostScreen extends StatefulWidget {
  final Post post;

  EditPostScreen({required this.post});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _imgController;
  late TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.post.titulo);
    _imgController = TextEditingController(text: widget.post.img);
    _descricaoController = TextEditingController(text: widget.post.descricao);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _imgController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _updatePost() async {
    // Atualizar o post usando a API
    Post updatedPost = Post(
      id: widget.post.id,
      titulo: _tituloController.text,
      img: _imgController.text,
      descricao: _descricaoController.text,
      dataDePostagem: widget.post.dataDePostagem,
    );

    await ApiService().updatePost(updatedPost);
    Navigator.pop(context, updatedPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Post')),
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
              onPressed: _updatePost,
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
