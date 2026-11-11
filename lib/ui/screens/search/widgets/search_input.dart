import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';

/// TODO: Ubah SearchInput menjadi ConsumerStatefulWidget
class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({super.key});

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).clear();
    // Hapus query dari searchQueryProvider
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Dengarkan perubahan searchQueryProvider dari luar (misal: saat klik topik rekomendasi)
    ref.listen(searchQueryProvider, (_, next) {
      if (_controller.text != next) _controller.text = next;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length) // membaca pilihan kita dari chip sebagai text
      );
    });
    final scheme = Theme.of(context).colorScheme;

    return SearchBar(
      controller: _controller,
      hintText: 'Cari berita, topik, atau tokoh',
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(scheme.surfaceContainerHigh),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 16),
      ),
      leading: const Icon(Icons.search_rounded),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        // Simpan value ke searchQueryProvider
        ref.read(searchQueryProvider.notifier).submit(value);
      },
      trailing: [
        ListenableBuilder(
          listenable: _controller,
          builder: (_, _) => _controller.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  tooltip: 'Hapus',
                  icon: const Icon(Icons.close_rounded),
                  onPressed: _clear,
                ),
        ),
      ],
    );
  }
}
