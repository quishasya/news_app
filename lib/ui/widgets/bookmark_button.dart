import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/bookmark_provider.dart';

import '../../data/models/article.dart';

/// TODO: Ubah BookmarkButton menjadi ConsumerWidget
class BookmarkButton extends ConsumerWidget {
  const BookmarkButton({super.key, required this.article, this.tonal = false});

  final Article article;

  /// Pakai gaya filled tonal (cocok di atas gambar).
  final bool tonal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);

    final isSaved = bookmarks.any(
      (item) => item.url == article.url,
    );
    void onPressed() {
      // TODO: Panggil method toggle() dari bookmarksProvider
      ref.read(bookmarksProvider.notifier).toggle(article);
    }
    
    final tooltip = isSaved ? 'Hapus dari Tersimpan' : 'Simpan';
    const icon = Icon(Icons.bookmark_border_rounded);
    const selectedIcon = Icon(Icons.bookmark_rounded);

    if (tonal) {
      return IconButton.filledTonal(
        tooltip: tooltip,
        isSelected: isSaved,
        icon: icon,
        selectedIcon: selectedIcon,
        onPressed: onPressed,
      );
    }
    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      isSelected: isSaved,
      icon: icon,
      selectedIcon: selectedIcon,
      onPressed: onPressed,
    );
  }
}
