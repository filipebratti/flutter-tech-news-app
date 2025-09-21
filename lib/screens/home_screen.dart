import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/news_card.dart';
import '../models/news_article.dart';
import '../constants/app_strings.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  // Lista de categorias exibidas nas abas
  final List<String> categories = [
    'Todas',
    'IA & ML',
    'Mobile',
    'Web',
    'Cloud',
    'Segurança',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.code,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              AppStrings.appTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Implementar notificações
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: categories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
            categories.map((category) => _buildNewsListView(category)).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: AppStrings.saved,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: AppStrings.trending,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }

  /// Constrói a lista de notícias para a categoria selecionada
  Widget _buildNewsListView(String category) {
    final articles = _getMockArticles(category);

    return RefreshIndicator(
      onRefresh: () async {
        // Simula um refresh (poderia chamar API futuramente)
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return NewsCard(article: articles[index]);
        },
      ),
    );
  }

  /// Retorna uma lista mock de artigos para demonstração
  List<NewsArticle> _getMockArticles(String category) {
    return [
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
  }
}
