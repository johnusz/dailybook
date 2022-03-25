

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

class Article {
  Article({
    required this.articles,
  });

  List<ArticleElement> articles;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    articles: List<ArticleElement>.from(json["articles"].map((x) => ArticleElement.fromJson(x))),
  );

}

class ArticleElement {
  ArticleElement({
    this.author,
    this.url,
    this.source,
    this.title,
    this.description,
    this.image,
    this.date,
  });

  String? author;
  String? url;
  String? source;
  String? title;
  String? description;
  String? image;
  DateTime? date;

  factory ArticleElement.fromJson(Map<String, dynamic> json) => ArticleElement(
    author: json["author"] == null ? null : json["author"],
    url: json["url"],
    source: json["source"],
    title: json["title"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
    date: DateTime.parse(json["date"]),
  );

}
