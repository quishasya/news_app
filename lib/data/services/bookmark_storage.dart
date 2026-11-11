// penyimpanan lokal artikel yang di bookmark (shared_preferences)
import 'dart:convert';

import 'package:news_app/data/models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkStorage {
  static const String _key = 'bookmarked_articles';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<List<Article>> load() async {
    final raw = await _prefs.getStringList(_key) ?? [];
    return raw
        .map(
          (item) => Article.fromJson(jsonDecode(item) as Map<String, dynamic>)
        )
        // untuk ubah format string menjadi json, dan untuk mencocokkan tipe data yang Map, menjadi List.
        .toList();
  }

  // function yang dijalankan ketika user menyimpan artikel ke bookmark
  Future<void> save(List<Article> articles) {
    final raw = articles
        .map((article) => jsonEncode(article.toJson()))
        .toList();
    return _prefs.setStringList(_key, raw);
  }
}