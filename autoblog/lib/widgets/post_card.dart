// lib/widgets/post_card.dart
import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PostCard({
    required this.post,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Carrega a imagem do post com um placeholder e tratamento de erro
          FadeInImage(
            image: post.img.isNotEmpty
                ? NetworkImage(post.img)
                : AssetImage('assets/images/placeholder_img.png')
                    as ImageProvider,
            placeholder: AssetImage('assets/images/placeholder_img.png'),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/placeholder_img.png');
            },
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          ListTile(
            title: Text(
              post.titulo,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(post.descricao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onDelete,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
