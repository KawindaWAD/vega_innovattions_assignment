import 'package:equatable/equatable.dart';

class News extends Equatable {
  const News({
    required this.totalResults,
    required this.articles,
  });

  final int totalResults;
  final List<Article> articles;

  @override
  List<Object> get props => [totalResults, articles];
}

class Article extends Equatable {
  const Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  @override
  List<Object> get props =>
      [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}

class Source extends Equatable {
  const Source({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
