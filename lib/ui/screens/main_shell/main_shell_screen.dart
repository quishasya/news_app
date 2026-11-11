import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/navigation_provider.dart';

import '../bookmarks/bookmarks_screen.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';
import 'widgets/app_navigation_bar.dart';

/// TODO: Ubah MainShellScreen menjadi ConsumerWidget saat Riverpod diimplementasikan
class MainShellScreen extends ConsumerWidget {
  const MainShellScreen({super.key});

  static const _pages = [
    HomeScreen(),
    SearchScreen(),
    BookmarksScreen()
  ];

    @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: AppNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => ref.read(navigationProvider.notifier).select(index)
      ),
    );
  }
}
