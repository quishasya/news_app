import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/theme_provider.dart';

import 'core/theme/app_theme.dart';
import 'ui/screens/main_shell/main_shell_screen.dart';

// ConsumerWidget adalah Class yang berfungsi untuk mendengarkan dan merespon perubahan status (state), kemudian
// memperbarui bagian antarmuka (UI) yang terkait secara otomatis tanpa harus merender ulang seluruh halaman aplikasi
class NewsApp extends ConsumerWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Warta',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      // TODO: Gunakan ref.watch untuk mengambil mode tema
      themeMode: ref.watch(ThemeModeProvider),
      home: const MainShellScreen(),
    );
  }
}
