import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/ui/widgets/empty_state.dart';
import 'package:news_app/ui/widgets/error_state.dart';
import 'package:news_app/ui/widgets/loading_skeleton.dart';

import '../../../widgets/article_tile.dart';
import 'featured_article_card.dart';

/// Ubah HeadlinesSection menjadi ConsumerWidget
/// TODO: Gunakan AsyncValue.when dari headlinesProvider
class HeadlinesSection extends ConsumerWidget {
  const HeadlinesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectedCategoryProvider);
    final headlines = ref.watch(headlinesProvider(category));

    return headlines.when(
      loading: () => const SliverToBoxAdapter(child: LoadingSkeleton()),
      error: (error, _) => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorState(
          error: error,
          onRetry: () => ref.invalidate(headlinesProvider(category)), //
        ),
      ),
      data: (articles) {
        if (articles.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.newspaper_rounded,
              title: 'Belum ada Berita',
              message: 'Coba pilih kategori lain atau tarik untuk refresh',
            ),
          );
        } 
        return SliverPadding(
          padding: const EdgeInsets.only(bottom: 16),
          sliver: SliverList.separated(
            itemCount: articles.length,
            separatorBuilder: (_, _) =>
                const Divider(indent: 16, endIndent: 16),
            itemBuilder: (_, index) => index == 0
                ? FeaturedArticleCard(article: articles.first)
                : ArticleTile(article: articles[index]),
          ),
        );
      },
    );
  }
}
