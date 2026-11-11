// dependency injection: service & repository disediakan lewat provider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/repositories/news_repository.dart';
import 'package:news_app/data/services/bookmark_storage.dart';
import 'package:news_app/data/services/news_api_service.dart';

final newsApiServiceProvider = Provider<NewsApiService>(
  (ref) => NewsApiService()
);

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepository(ref.watch(newsApiServiceProvider))
);

final bookmarkStorageProvider = Provider<BookmarkStorage>(
  (ref) => BookmarkStorage()
);