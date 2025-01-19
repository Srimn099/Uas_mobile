import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2/everything';
  static const String _apiKey = 'cc36126af75e4eaeb67352c378caf10a';

  Future<List<Article>> fetchNews({String query = ''}) async {
    try {
      final url =
          Uri.parse('$_baseUrl?domains=wsj.com&q=$query&apiKey=$_apiKey');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List articles = data['articles'];
        return articles.map((article) => Article.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      throw Exception('Error fetching news: $error');
    }
  }
}
