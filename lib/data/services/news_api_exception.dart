/// Error dengan bahasa yang ramah untuk ditampilkan ke pengguna.
///
/// Detail teknis tidak pernah ditampilkan di layar; hanya [title] dan
/// [message] yang mudah dipahami.
class NewsApiException implements Exception {
  const NewsApiException(this.title, this.message);

  final String title;
  final String message;

  static const offline = NewsApiException(
    'Kamu sedang offline',
    'Periksa koneksi internetmu, lalu coba lagi ya.',
  );

  static const slowConnection = NewsApiException(
    'Koneksinya agak lambat',
    'Beritanya butuh waktu lebih lama dari biasanya. Coba lagi sebentar lagi.',
  );

  static const serviceUnavailable = NewsApiException(
    'Berita belum bisa ditampilkan',
    'Kami sedang mengalami kendala saat menghubungi layanan berita. '
    'Coba lagi nanti ya.',
  );

  static const tooManyRequests = NewsApiException(
    'Lagi ramai nih',
    'Terlalu banyak permintaan dalam waktu singkat. '
    'Istirahat sebentar, lalu coba lagi.',
  );

  static const serverBusy = NewsApiException(
    'Server sedang sibuk',
    'Layanan berita sedang istirahat sejenak. Coba lagi beberapa saat lagi.',
  );

  static const unknown = NewsApiException(
    'Ada yang tidak beres',
    'Beritanya gagal dimuat. Tenang, coba lagi ya.',
  );

  @override
  String toString() => message;
}
