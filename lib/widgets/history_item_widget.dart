import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/history_entry.dart';
import '../providers/app_provider.dart';
import '../screens/translation_screen.dart';

/// Élément de liste pour l'historique et les favoris
class HistoryItemWidget extends StatelessWidget {
  final HistoryEntry entry;

  const HistoryItemWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final provider = context.read<AppProvider>();

    return Dismissible(
      key: Key(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline,
            color: Colors.white, size: 26),
      ),
      onDismissed: (_) => provider.deleteHistoryEntry(entry.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D2640) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              // Naviguer vers la traduction pour revoir ou relancer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      TranslationScreen(initialText: entry.inputText),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Texte original + actions ──────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.inputText,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Bouton favori
                      GestureDetector(
                        onTap: () => provider.toggleFavorite(entry.id),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            entry.isFavorite
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: entry.isFavorite
                                ? Colors.amber.shade600
                                : (isDark
                                    ? Colors.white38
                                    : Colors.black26),
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ── Aperçu des emojis des signes ──────────────────────
                  if (entry.results.isNotEmpty) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: entry.results.take(8).map((r) {
                          if (r.isFound && r.sign != null) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                r.sign!.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF4A4060)
                                      : const Color(0xFFF0EDF8),
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Text('?',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey)),
                                ),
                              ),
                            );
                          }
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // ── Stats + date ──────────────────────────────────────
                  Row(
                    children: [
                      // Taux de traduction
                      Flexible(
                        child: _StatBadge(
                          label:
                              '${entry.foundCount}/${entry.results.length} traduits',
                          color: entry.translationRate > 0.7
                              ? Colors.green.shade600
                              : entry.translationRate > 0.4
                                  ? Colors.orange.shade600
                                  : Colors.red.shade400,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Date
                      Flexible(
                        child: Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(entry.timestamp),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? Colors.white38
                                : Colors.black38,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
