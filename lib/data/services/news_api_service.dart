// import '../../core/constants/api_constants.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/data/services/news_api_exception.dart';
import '../models/article.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// TODO 3: Implementasi NewsApiService
// 1. Install package http: flutter pub add http
// 2. Import 'package:http/http.dart' as http;
// 3. Buat fungsi getTopHeadlines(String category) yang memanggil endpoint /v2/top-headlines
// 4. Buat fungsi searchArticles(String query) yang memanggil endpoint /v2/everything
// 5. Tangani error menggunakan NewsApiException

//service tingkat rendah yang berbicara langsung dengan NewsAPI.
class NewsApiService {
  // Dependency Injection (DI) => suatu teknik penyuntikan / memasukkan objek (http.Client) dari luar class, bukan dibuat langsung di dalam class ini.
  // Tujuan => memudahkan testing dengan memasukkan client tiruan (mock) tanpa harus terhubung ke internet sungguhan.
  // tanda ?? => jika client tida diisi (null) otomatis akan memakai http.Client() standar bawaan

  // Variable privat untuk menyimpan client HTTP yang digunakan untuk berkomunikasi dengan server
  final http.Client _client;

  // Constructor, didefinisikan sebelum method async
  NewsApiService({http.Client? client}) : _client = client ?? http.Client();

  // untuk ngambil daftar berita utama berdasarkan kategori negara dan category
  Future<List<Article>> fetchTopHeadlines(String category) async {
    // Implementasi fetch API di sini
    return _get('/top-headlines', {
      'country' : ApiConstants.country, // Request parameters
      'category' : category,
    });
  }

  // untuk mencari artikel berdasarkan kata kunci (query) diurutkan dari yang paling baru terbit (publishedAt)
  Future<List<Article>> searchArticles(String query) async {
    // Implementasi fetch API di sini
    return _get('/everything', {
      'q': query,
      'sortBy': 'publishedAt',
      'language': ApiConstants.language,
    });
  }

  // Helper method membantu agar kita tidak menulis ulang kode request (HTTP) berkali kali
  Future<List<Article>> _get(String path, Map<String, String> params) async {
    // validasi: cek apakah API Key sudah diisi di file .env agar tida terjadi kegagalan outentivikasi
    final apiKey = ApiConstants.apiKey;
    if (apiKey.isEmpty) {
      // petunjuk teknis hanya untuk developer
      debugPrint('[Warta] NEWS_API_KEY kosong. Isi API Key di file .env');
      throw NewsApiException.serviceUnavailable; // ketika layanan tidak tersedia
    }
    // Membangun url lengkap : menggabungkan base URL + endpoint tujuan (path) 
    // lalu menyisipkan query parameters (parameter pencarian serta batas jumlah data/pageSize)
    final uri = Uri.parse('${ApiConstants.baseUrl}$path').replace(
      queryParameters: {...params, 'pageSize': '$ApiConstants.pageSize'} // spread operator => untuk memastikan tidak ada object yang tertinggal
    );

    try{
      // Mengirim request GET ke server dengan header 'X-Api-Key' sebagai tiket izin akses, 
      // serta batas waktu tunggu (.timeout) agar aplikasi tidak menggantung jika server lambat merespons
      final response = await _client 
          .get(uri, headers: {'X-Api-Key' : apiKey})
          .timeout(ApiConstants.timeout);

      // cek status code HTTP: code 200 bearti request sukses (OK)
      // jika bukan 200, lempar error khusus sesuai kode status
      if (response.statusCode != 200) {
        debugPrint('[Warta] HTTP ${response.statusCode}: ${response.body}');
        throw _formStatusCode(response.statusCode);
      }

      // JSON Decoding: Mengubah data mentah berupa teks string dari server menjadi format MAP DART.
      final body = jsonDecode(response.body) as Map<String, dynamic>;

      // mengambil daftar artikel dari key 'articels'. jika null / tidak ada, gunakan liat kosong [] sebagai cadangan.
      final articles = body['articles'] as List<dynamic>? ?? [];
      // Data mapping: mengubah setiap data json menjadi sebuah objek atau properties, yang akan ditampilkan pada return output hanyalah data yang valid/lengkap.
      return articles
          .map((json) => Article.fromJson(json as Map<String, dynamic>)) 
          .where((articles) => articles.isValid)
          .toList();

    // Throw: meneruskan kembali NewsApiException ke fungsi pemanggil tanpa mengubah jenis error
    } on NewsApiException {
      rethrow;
    //socketException: Error koneksi pada level sistem operasi (low level error)
    } on SocketException {
      throw NewsApiException.offline;
    // client Exception: Error pada koneksi HTTP (DNS gagal menemukan alamat server atau koneksi terputus tiba tiba)
    } on http.ClientException {
      throw NewsApiException.offline;
    } on TimeoutException {
      throw NewsApiException.slowConnection;
    // Catch: Menangkap sebuah error tak terduga lainnya (fallback), agar aplikasi tidak crash/keluar sendiri (force close)
    } catch (error) {
      debugPrint('[Warta] Unexpected error: $error');
      throw  NewsApiException.unknown;
    }
  }

  // Swtich Expression (fitur pattern matching di Dart 3) cara ringkas mencocokan kode status HTTP dengan error NewsApiException
  NewsApiException _formStatusCode(int code) => switch (code) {
  // 401 (unauthorized): API key salah/tidak ada. 403 (forbidden): akses ditolak server
  401 || 403 => NewsApiException.serviceUnavailable,
  // 492 (too many request): batas kuota request API habis
  429 => NewsApiException.tooManyRequests,
  // 500 - 599 (Server Error): Terjadi ketika masalah terjadi di server
  >= 500 => NewsApiException.serverBusy,
  // Garis bawah (_) adalah wildcard/defoult: menangani kode HTTP lainnya yang tidak disebutkan di atas
  _ => NewsApiException.unknown
  };
}