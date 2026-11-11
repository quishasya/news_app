import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/bookmark_provider.dart';

import '../../widgets/empty_state.dart';
import '../../widgets/theme_toggle_button.dart';
import 'widgets/bookmark_item.dart';

/// TODO: Ubah BookmarksScreen menjadi ConsumerWidget
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Tersimpan'),
          actions: [ThemeToggleButton(), SizedBox(width: 8)],
        ),
        if (bookmarks.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.bookmark_border_rounded,
              title: 'Belum ada berita tersimpan',
              message:
                  'Ketuk ikon bookmark pada berita\nuntuk membacanya nanti.',
            ),
          )
        else
          SliverList.separated(
            itemCount: bookmarks.length,
            separatorBuilder: (_, _) =>
                const Divider(indent: 16, endIndent: 16),
            itemBuilder: (_, index) => BookmarkItem(article: bookmarks[index]),
          ),
      ],
    );
  }
}
