import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutomoBlog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Blog Automotivo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:5000/postagem'));
      if (response.statusCode == 200) {
        setState(() {
          posts = json.decode(response.body);
        });
      } else {
        throw Exception('Falha ao carregar dados');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Exibe a imagem grande no topo
                      if (post['img'] != null)
                        Image.network(
                          post['img'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título em estilo H1
                            Text(
                              post['Titulo'] ?? 'Sem Título',
                              style: const TextStyle(
                                fontSize: 24, // Tamanho do H1
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Descrição em estilo H3
                            Text(
                              post['Descricao'] ?? 'Sem Descrição',
                              style: const TextStyle(
                                fontSize: 16, // Tamanho do H3
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Data de postagem em estilo H3
                            Text(
                              post['Data de postagem'] ?? '',
                              style: const TextStyle(
                                fontSize: 16, // Tamanho do H3
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
