import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';

import '../../../../core/constants/news_category.dart';

/// TODO: Ubah CategoryChips menjadi ConsumerWidget saat Riverpod ditambahkan
class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const categories = NewsCategory.values;
    final selected = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ChoiceChip(
            label: Text(category.label),
            selected: category == selected,
            showCheckmark: false,
            onSelected: (_) => ref.read(selectedCategoryProvider.notifier).select(category),
          );
        },
      ),
    );
  }
}

