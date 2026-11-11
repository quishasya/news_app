// TODO 7: Implementasi NavigationProvider
// 1. Buat class NavigationNotifier extends Notifier<int> untuk menyimpan state index tab aktif
// 2. Implementasikan fungsi setIndex(int index) untuk mengubah state
// 3. Buat navigationProvider (NotifierProvider) untuk digunakan di BottomNavigationBar

// Index untuk tab yang aktif pada bottomNavBar
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends Notifier<int>{
  @override
  int build() => 0;

  void select(int index) => state = index;
}

final navigationProvider = NotifierProvider<NavigationNotifier, int>(
  NavigationNotifier.new,
);