import 'package:flutter/material.dart';
import '../services/news_service.dart';
import '../models/article_model.dart';
import 'article_details_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> _allArticles = [];
  List<Article> _filteredArticles = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true; // Tambahkan variabel loading

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      List<Article> articles = await NewsService().fetchNews();
      setState(() {
        _allArticles = articles;
        _filteredArticles = articles;
        _isLoading = false; // Data selesai diambil
      });
    } catch (error) {
      setState(() {
        _isLoading = false; // Hentikan loading meskipun ada error
      });
      print('Error fetching articles: $error');
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredArticles =
            _allArticles; // Tampilkan semua artikel jika query kosong
      } else {
        _filteredArticles = _allArticles
            .where((article) =>
                article.title.toLowerCase().contains(query.toLowerCase()) ||
                article.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Terkini'),
        backgroundColor: Colors.teal[400],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/halamanpilihan');
          },
        ),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari Berita...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator()) // Indikator loading
                : _filteredArticles.isEmpty
                    ? const Center(child: Text('No articles found'))
                    : ListView.builder(
                        itemCount: _filteredArticles.length,
                        itemBuilder: (context, index) {
                          final article = _filteredArticles[index];
                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: article.urlToImage.isNotEmpty
                                  ? Image.network(
                                      article.urlToImage,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              title: Text(article.title),
                              subtitle: Text(article.description),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ArticleDetailsPage(article: article),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
