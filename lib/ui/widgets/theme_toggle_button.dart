import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/theme_provider.dart';

/// TODO: Ubah ThemeToggleButton menjadi ConsumerWidget
class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return IconButton(
      tooltip: isDark ? 'Mode terang' : 'Mode gelap',
      onPressed: () {
        // TODO: Panggil method toggle dari themeModeProvider
        ref.read(ThemeModeProvider.notifier).toggle(brightness);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => RotationTransition(
          turns: Tween(begin: 0.75, end: 1.0).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
        ),
      ),
    );
  }
}
