import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../widgets/news_card.dart';
import '../constants/app_strings.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<NewsArticle> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: AppStrings.searchHint,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
          onSubmitted: _performSearch,
          onChanged: (value) {
            _performSearch(value);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _performSearch(_searchController.text),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_searchResults.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              AppStrings.noResults,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.tryDifferentKeywords,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              AppStrings.typeToSearch,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return NewsCard(article: _searchResults[index]);
      },
    );
  }

  void _performSearch(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = false;
      _searchResults = _getMockSearchResults(trimmed);
    });
  }

  List<NewsArticle> _getMockSearchResults(String query) {
    // Simular resultados de busca (mesmos artigos da HomeScreen)
    final allArticles = [
      NewsArticle(
        id: '1',
        title: AppStrings.flutterRelease,
        summary: AppStrings.flutterSummary,
        content: AppStrings.articleContent,
        author: AppStrings.authorJoao,
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
        imageUrl:
            'https://via.placeholder.com/300x200/1565C0/FFFFFF?text=Flutter',
        category: AppStrings.mobile,
        tags: ['Flutter', AppStrings.mobile, 'Desenvolvimento'],
      ),
      NewsArticle(
        id: '2',
        title: AppStrings.aiTitle,
        summary: AppStrings.aiSummary,
        content: AppStrings.articleContent,
        author: AppStrings.authorMaria,
        publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
        imageUrl: 'https://via.placeholder.com/300x200/00BCD4/FFFFFF?text=AI',
        category: AppStrings.iaMl,
        tags: ['IA', 'Machine Learning', 'Desenvolvimento'],
      ),
      NewsArticle(
        id: '3',
        title: AppStrings.kubernetesTitle,
        summary: AppStrings.kubernetesSummary,
        content: AppStrings.articleContent,
        author: AppStrings.authorPedro,
        publishedAt: DateTime.now().subtract(const Duration(hours: 6)),
        imageUrl: 'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=K8s',
        category: AppStrings.cloud,
        tags: ['Kubernetes', AppStrings.cloud, 'DevOps'],
      ),
      NewsArticle(
        id: '4',
        title: AppStrings.reactTitle,
        summary: AppStrings.reactSummary,
        content: AppStrings.articleContent,
        author: AppStrings.authorAna,
        publishedAt: DateTime.now().subtract(const Duration(hours: 8)),
        imageUrl:
            'https://via.placeholder.com/300x200/61DAFB/000000?text=React',
        category: AppStrings.web,
        tags: ['React', 'JavaScript', 'Frontend'],
      ),
    ];

    // Filtrar artigos baseado na query
    return allArticles.where((article) {
      final queryLower = query.toLowerCase();
      return article.title.toLowerCase().contains(queryLower) ||
          article.summary.toLowerCase().contains(queryLower) ||
          article.tags.any((tag) => tag.toLowerCase().contains(queryLower));
    }).toList();
  }
}
