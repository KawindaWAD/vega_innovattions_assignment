import 'dart:convert';

import 'package:vega_innovattions_assignmen/features/common/domain/entities/news_entity.dart';

NewsModel newsFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: json["articles"] == null ? [] : List<ArticleModel>.from(json["articles"]!.map((x) => ArticleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": articles == null ? [] : List<dynamic>.from(articles!.map((x) => x.toJson())),
  };

  News toEntity() => News(
        totalResults: totalResults ?? 0,
        articles: List<Article>.from(
          (articles ?? []).map(
            (e) => Article(
              source: Source(
                id: e.source?.id??'',
                name: e.source?.name??'',
              ),
              author: e.author ?? '',
              title: e.title ?? '',
              description: e.description ?? '',
              url: e.url ?? '',
              urlToImage: e.urlToImage ?? '',
              publishedAt: e.publishedAt ?? DateTime(2023),
              content: e.content ?? '',
            ),
          ),
        ),
      );
}

class ArticleModel {
  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final SourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    source: json["source"] == null ? null : SourceModel.fromJson(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source?.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt?.toIso8601String(),
    "content": content,
  };
}

class SourceModel {
  SourceModel({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
