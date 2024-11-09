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
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Titulo': post.titulo,
          'img': post.img,
          'Descricao': post.descricao,
          'Data de postagem': post.dataDePostagem,
          // O ID é opcional aqui; remova se o servidor gera automaticamente
          'id': post.id.isEmpty ? null : post.id,
        }),
      );

      if (response.statusCode == 201) {
        print('Post criado com sucesso');
      } else {
        print('Falha ao criar o post. Código: ${response.statusCode}');
        print('Resposta: ${response.body}');
        throw Exception('Falha ao criar o post');
      }
    } catch (e) {
      print('Erro ao tentar criar o post: $e');
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

    if (response.statusCode == 200) {
      print("Post deletado com sucesso");
    } else if (response.statusCode == 404) {
      print("Erro 404: Post não encontrado");
      throw Exception("Erro: Post não encontrado");
    } else {
      print('Erro ao deletar post: ${response.statusCode} - ${response.body}');
      throw Exception('Falha ao deletar o post');
    }
  }
}
