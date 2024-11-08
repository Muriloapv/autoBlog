import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(post.img),
          ListTile(
            title: Text(post.titulo),
            subtitle: Text(post.descricao),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Postado em: ${post.dataDePostagem}'),
          ),
        ],
      ),
    );
  }
}
