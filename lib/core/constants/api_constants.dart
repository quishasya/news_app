import 'package:flutter_dotenv/flutter_dotenv.dart';

// TODO 2: Setup API Constants
// 1. Definisikan baseUrl NewsAPI
// 2. Buat getter untuk mengambil API Key dari dotenv
// 3. Tentukan country (misal: 'us') dan language (misal: 'en')

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://newsapi.org/v2'; // Isi dengan base URL NewsAPI
  
  // nge GET API nya secara asynchronous saat aplikasi dibuka
  static String get apiKey => (dotenv.maybeGet('NEWS_API_KEY') ?? '').trim();

  // untuk klasifikasi negara yang akan ditampilkan di top-headlines
  static const String country = 'id';
  
  // bahasa yang akan ditampilkan ketika proses pencarian
  static const String language = 'en';

  // memberitahu berapa banyak berita yang akan ditampilkan dalam sekali request
  static const int pageSize = 30;

  // sebagai batas waktu berapa lama aplikasi/client dapat terhubung dengan API
  static const Duration timeout = Duration(seconds: 15);
}
