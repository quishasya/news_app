import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';

/// TODO: Ubah SearchSuggestions menjadi ConsumerWidget
class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({super.key});

  static const _topics = [
    'Artificial Intelligence',
    'Climate',
    'Economy',
    'Football',
    'Space',
    'Startup',
    'Health',
    'Election',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Topik populer', style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final topic in _topics)
              ActionChip(
                avatar: const Icon(Icons.trending_up_rounded, size: 18),
                label: Text(topic),
                onPressed: () {
                  // submit topik ke searchQueryProvider
                  ref.read(searchQueryProvider.notifier).submit(topic);
                },
              ),
          ],
        ),
      ],
    );
  }
}
