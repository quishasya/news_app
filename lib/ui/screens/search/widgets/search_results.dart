import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';
import 'package:news_app/ui/widgets/article_tile.dart';
import 'package:news_app/ui/widgets/empty_state.dart';
import 'package:news_app/ui/widgets/error_state.dart';
import 'package:news_app/ui/widgets/loading_skeleton.dart';

import 'search_suggestions.dart';

// TODO: Ubah SearchResults menjadi ConsumerWidget
class SearchResults extends ConsumerWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Gunakan ref.watch(searchQueryProvider)
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) return const SearchSuggestions();

    final searchResults = ref.watch(searchResultsProvider);
    
    return searchResults.when(
      loading: () => SingleChildScrollView(
        child: LoadingSkeleton(),
      ),
      error: (error, _) => ErrorState(
        error: error,
        onRetry: () => ref.invalidate(searchResultsProvider),
      ),
      data: (articles) {
        if (articles.isEmpty) {
          return EmptyState(
            icon: Icons.search_off_rounded, 
            title: 'Tidak ada Hasil', 
            message: 'Coba kata kunci lain atau periksa ejaan anda'
          );
        }
        return ListView.separated(
          itemCount: articles.length,
          separatorBuilder: (_, _) => Divider(indent: 16, endIndent: 16),
          itemBuilder: (context, index) => ArticleTile(article: articles[index]),
        );
      },
    );
  }
}
