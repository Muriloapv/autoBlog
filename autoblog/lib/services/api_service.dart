// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/informacoes';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Post.fromJson(data)).toList();
    } else {
      throw Exception('Falha ao carregar posts');
    }
  }

  Future<void> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Titulo': post.titulo,
        'img': post.img,
        'Descricao': post.descricao,
        'Data de postagem': post.dataDePostagem,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao criar o post');
    }
  }

  Future<void> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Titulo': post.titulo,
        'img': post.img,
        'Descricao': post.descricao,
        'Data de postagem': post.dataDePostagem,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar o post');
    }
  }

  Future<void> deletePost(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar o post');
    }
  }
}