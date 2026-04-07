import 'package:flutter/material.dart';
import '../models/sign_model.dart';
import '../models/translation_result.dart';
import '../screens/sign_detail_screen.dart';
import 'finger_spell_widget.dart';

/// Carte affichée quand un mot n'est pas trouvé dans la base LSF.
class UnknownWordCard extends StatefulWidget {
  final TranslationResult result;

  const UnknownWordCard({super.key, required this.result});

  @override
  State<UnknownWordCard> createState() => _UnknownWordCardState();
}

class _UnknownWordCardState extends State<UnknownWordCard> {
  bool _showFingerSpell = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // La carte a une largeur fixe + hauteur max calée sur le SizedBox parent (280)
    return SizedBox(
      width: 220,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D2640) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? const Color(0xFF4A4060)
                : const Color(0xFFE5E0F8),
            width: 1.5,
          ),
        ),
        // SingleChildScrollView vertical : évite tout overflow peu importe le contenu
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── En-tête ──────────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF3D3560)
                        : const Color(0xFFFFF3E0),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      const Text('❓', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '"${widget.result.originalWord}"',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Mot non trouvé',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.orange.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Contenu ───────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Suggestions proches
                      if (widget.result.suggestions.isNotEmpty) ...[
                        Text(
                          'Suggestions :',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: widget.result.suggestions
                              .map((s) => _SuggestionChip(sign: s))
                              .toList(),
                        ),
                        const SizedBox(height: 10),
                      ],

                      // Bouton épellation
                      GestureDetector(
                        onTap: () => setState(
                            () => _showFingerSpell = !_showFingerSpell),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF3D3560)
                                : const Color(0xFFEDE9FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🤟',
                                  style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  _showFingerSpell
                                      ? 'Masquer épellation'
                                      : 'Épeler lettre par lettre',
                                  style: const TextStyle(
                                    color: Color(0xFF5E35B1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                _showFingerSpell
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: const Color(0xFF5E35B1),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Épellation lettre par lettre
                      if (_showFingerSpell) ...[
                        const SizedBox(height: 10),
                        FingerSpellWidget(
                          word: widget.result.originalWord,
                          compact: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Chip cliquable pour une suggestion de signe proche
class _SuggestionChip extends StatelessWidget {
  final SignModel sign;

  const _SuggestionChip({required this.sign});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SignDetailScreen(sign: sign)),
      ),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: sign.category.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: sign.category.color.withValues(alpha: 0.30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(sign.emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 4),
            Text(
              sign.word,
              style: TextStyle(
                color: sign.category.color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
