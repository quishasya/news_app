// TODO 6: Implementasi ThemeProvider
// 1. Install Riverpod: `flutter pub add flutter_riverpod`
// 2. Import 'package:flutter_riverpod/flutter_riverpod.dart';
// 3. Buat class ThemeNotifier extends Notifier<bool> (menyimpan state isDarkMode)
// 4. Implementasikan fungsi toggleTheme() untuk mengubah state dan menyimpannya di SharedPreferences
// 5. Buat themeProvider (NotifierProvider) untuk digunakan di UI

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/services/theme_storage.dart';

final ThemeStorageProvider = Provider<ThemeStorage>((ref) => ThemeStorage());

// Tema awal yang dibaca di 'main.dart' sebelum app tampil (berjalan secara asinkron)
// Nilainya di-override lewat 'ProviderScope.override'

final initialThemeModeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

// mode tema aktif: terang/gelap (default mengikuti sistem)
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(initialThemeModeProvider);

  // Beralih ke kebalikan dari tema yang sedang aktif
  void toggle(Brightness currentBrightness) {
    state = currentBrightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    ref.read(ThemeStorageProvider).save(state);
  }
  
}

final ThemeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new
);
