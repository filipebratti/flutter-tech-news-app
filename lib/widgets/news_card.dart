import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/news_article.dart';
import '../screens/article_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailScreen(article: article),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do artigo
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.accent,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(article.category),
                    size: 48,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),

            // Conteúdo do card
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoria e tempo
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article.category,
                          style: const TextStyle(
                            color: Color(0xFF1565C0),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _getTimeAgo(article.publishedAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Título
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Resumo
                  Text(
                    article.summary,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Autor e ações
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: const Color(0xFF1565C0),
                        child: Text(
                          article.author[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          article.author,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_outline),
                        iconSize: 20,
                        onPressed: () {
                          // Implementar salvar artigo
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined),
                        iconSize: 20,
                        onPressed: () {
                          // Implementar compartilhar
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case AppStrings.iaMl:
        return Icons.psychology;
      case AppStrings.mobile:
        return Icons.smartphone;
      case AppStrings.web:
        return Icons.web;
      case AppStrings.cloud:
        return Icons.cloud;
      case AppStrings.security:
        return Icons.security;
      default:
        return Icons.article;
    }
  }

  String _getTimeAgo(DateTime publishedAt) {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m atrás';
    } else {
      return AppStrings.now;
    }
  }
}
