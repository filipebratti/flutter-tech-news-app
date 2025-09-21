class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String author;
  final DateTime publishedAt;
  final String imageUrl;
  final String category;
  final List<String> tags;

  NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.author,
    required this.publishedAt,
    required this.imageUrl,
    required this.category,
    required this.tags,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      content: json['content'],
      author: json['author'],
      publishedAt: DateTime.parse(json['publishedAt']),
      imageUrl: json['imageUrl'],
      category: json['category'],
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'author': author,
      'publishedAt': publishedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'category': category,
      'tags': tags,
    };
  }
}

