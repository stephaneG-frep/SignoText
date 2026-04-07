import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/history_item_widget.dart';

/// Écran de l'historique des traductions
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Historique',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            )),
                        Text(
                          'Vos traductions récentes',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? Colors.white54
                                : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bouton effacer tout
                  Consumer<AppProvider>(
                    builder: (context, provider, _) {
                      if (provider.history.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return IconButton(
                        onPressed: () => _confirmClear(context, provider),
                        icon: const Icon(Icons.delete_sweep_outlined),
                        tooltip: 'Effacer tout',
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Liste ───────────────────────────────────────────────────
            Expanded(
              child: Consumer<AppProvider>(
                builder: (context, provider, _) {
                  if (provider.history.isEmpty) {
                    return const _EmptyHistory();
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: provider.history.length,
                    itemBuilder: (context, index) =>
                        HistoryItemWidget(entry: provider.history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmClear(
      BuildContext context, AppProvider provider) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Effacer l\'historique ?'),
        content: const Text(
            'Toutes vos traductions seront supprimées. Les favoris seront également perdus.'),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade400),
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await provider.clearHistory();
    }
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('📋', style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'Aucune traduction pour l\'instant',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos traductions apparaîtront ici',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
          ),
        ],
      ),
    );
  }
}
