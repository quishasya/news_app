import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/services/theme_storage.dart';
import 'package:news_app/providers/theme_provider.dart';

import 'app.dart';

Future<void> main() async {
  // Selama proses inisialisasi ini, native splash screen tetap tampil.
  // class yang akan di load pertama kali saat aplikasi dijalankan
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(isOptional: true); // mengambil APIKey
  await initializeDateFormatting('id_ID'); // menyesuaikan format tanggal bahasa indonesia
  final initialTheme = await ThemeStorage().load(); // load tema aplikasi sesuai tema sistem 

  runApp(
    // TODO: Bungkus NewsApp dengan ProviderScope saat mengimplementasikan Riverpod
    // provider untuk management state.
    ProviderScope(
      // matikan auto-retry bawaan riverpod agar kuota API tidak cepat habis.
      retry: (retryCount, error) => null,
      overrides: [
        // sebuah kondisi, dimana ada kemungkinan perubahan state.
        initialThemeModeProvider.overrideWithValue(initialTheme)
      ],
      child: NewsApp(),
    )
  );
}
