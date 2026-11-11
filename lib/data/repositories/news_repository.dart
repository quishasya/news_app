import 'package:news_app/core/constants/news_category.dart';

import '../models/article.dart';
import '../services/news_api_service.dart';

// TODO 5: Implementasi NewsRepository
// 1. Repository bertugas menjadi perantara antara UI/Provider dengan Service
// 2. Menerima dependensi NewsApiService
// 3. Buat fungsi untuk get top headlines dan hapus artikel duplikat berdasarkan URL
// 4. Buat fungsi untuk search articles dan hapus artikel duplikat

class NewsRepository {
  NewsRepository(this._apiService);
  
  final NewsApiService _apiService;

  Future<List<Article>> getTopHeadlines(NewsCategory category) async {
    return _apiService.fetchTopHeadlines(category.apiValue);
  }

  Future<List<Article>> searchArticles(String query) async {
    return _apiService.searchArticles(query);
  }
}
