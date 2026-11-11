// import '../data/models/article.dart';

// TODO 8: Implementasi HeadlinesProvider
// 1. Buat class HeadlinesNotifier extends AsyncNotifier<List<Article>>
// 2. Di dalam build(), panggil NewsRepository.getTopHeadlines()
// 3. Buat fungsi fetchHeadlines(String category) untuk memuat ulang data dengan kategori berbeda
// 4. Buat headlinesProvider (AsyncNotifierProvider) untuk digunakan di UI

// kategori yang sedang dipilih di halamna beranda
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/constants/news_category.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/dependency_provider.dart';

class SelectedCategoryNotifier extends Notifier<NewsCategory> {
  @override
  NewsCategory build() => NewsCategory.general;

  void select(NewsCategory category) => state = category;
}

final selectedCategoryProvider = NotifierProvider<SelectedCategoryNotifier, NewsCategory>(
  SelectedCategoryNotifier.new
);

// Top Headline per-kategori
// Memakai `.family` sehingga hasil setiap kategori di cache saat user kembali ke kategori yang sama
// data akan langsung tampil tanpa request ulang (GET API Key).
final headlinesProvider = FutureProvider.family<List<Article>, NewsCategory>((ref, category) {
  return ref.watch(newsRepositoryProvider).getTopHeadlines(category);
});

// alur dari API agar siap dikonsumsi di UI 