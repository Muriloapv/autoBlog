// lib/models/post.dart
class Post {
  final String id;
  final String titulo;
  final String img;
  final String descricao;
  final String dataDePostagem;

  Post({
    required this.id,
    required this.titulo,
    required this.img,
    required this.descricao,
    required this.dataDePostagem,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '', // Valor padrão vazio
      titulo: json['Titulo'] ?? 'Título Indisponível',
      img: json['img'] ??
          'https://link-para-imagem-padrao.com/default.jpg', // Imagem padrão
      descricao: json['Descricao'] ?? 'Descrição não disponível',
      dataDePostagem: json['Data de postagem'] ?? 'Data não disponível',
    );
  }
}
