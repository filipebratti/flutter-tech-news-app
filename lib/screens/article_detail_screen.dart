import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/news_article.dart';
import '../constants/app_strings.dart';

class ArticleDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                    size: 64,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_outline),
                onPressed: () {
                  // Implementar salvar artigo
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Implementar compartilhar
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoria e data
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          article.category,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Título
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Autor
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          article.author[0].toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.background,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.author,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            AppStrings.authorRole,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Resumo
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Text(
                      article.summary,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Conteúdo do artigo
                  Text(
                    _getExpandedContent(article),
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: article.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '#$tag',
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),

                  // Ações
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Implementar curtir
                          },
                          icon: const Icon(Icons.thumb_up_outlined),
                          label: const Text('Curtir'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.background,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Implementar comentar
                          },
                          icon: const Icon(Icons.comment_outlined),
                          label: const Text('Comentar'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'IA & ML':
        return Icons.psychology;
      case 'Mobile':
        return Icons.smartphone;
      case 'Web':
        return Icons.web;
      case 'Cloud':
        return Icons.cloud;
      case 'Segurança':
        return Icons.security;
      default:
        return Icons.article;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getExpandedContent(NewsArticle article) {
    // Conteúdo expandido para demonstração
    return '''
O mundo da tecnologia está em constante evolução, e ${article.title.toLowerCase()} representa mais um marco importante nessa jornada.

Esta inovação promete transformar significativamente a forma como interagimos com a tecnologia no nosso dia a dia. Os especialistas da área destacam que essa mudança não é apenas uma melhoria incremental, mas sim uma revolução que pode redefinir padrões da indústria.

**Principais Benefícios:**

• Melhoria significativa na experiência do usuário
• Maior eficiência e performance
• Redução de custos operacionais
• Facilidade de implementação e manutenção

As empresas que adotarem essa tecnologia mais cedo terão uma vantagem competitiva significativa no mercado. A implementação adequada pode resultar em melhorias de até 40% na produtividade das equipes de desenvolvimento.

**Impacto no Mercado:**

O impacto dessa inovação no mercado brasileiro de tecnologia é esperado para ser substancial. Analistas preveem que a adoção em larga escala pode acontecer nos próximos 12 a 18 meses, especialmente em empresas de médio e grande porte.

Para desenvolvedores e profissionais de TI, isso significa novas oportunidades de carreira e a necessidade de atualização constante das habilidades técnicas. Recomenda-se que os profissionais busquem capacitação específica nesta área para se manterem competitivos no mercado.

**Conclusão:**

Esta é apenas uma das muitas inovações que continuarão a moldar o futuro da tecnologia. Manter-se atualizado com essas tendências é essencial para qualquer profissional ou empresa que deseje prosperar no ambiente digital atual.
    ''';
  }
}
