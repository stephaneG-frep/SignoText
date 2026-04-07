import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/history_item_widget.dart';

/// Écran des traductions marquées comme favorites
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Favoris',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      )),
                  Text(
                    'Vos traductions sauvegardées',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),

            // ── Liste ───────────────────────────────────────────────────
            Expanded(
              child: Consumer<AppProvider>(
                builder: (context, provider, _) {
                  final favorites = provider.favorites;
                  if (favorites.isEmpty) {
                    return const _EmptyFavorites();
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) =>
                        HistoryItemWidget(entry: favorites[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('⭐', style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'Aucun favori pour l\'instant',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Appuyez sur ⭐ dans l\'historique\npour sauvegarder une traduction',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white38 : Colors.black38,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}
