import 'package:flutter/material.dart';
import '../models/sign_model.dart';
import '../data/signs_data.dart';
import '../widgets/sign_video_player.dart';

/// Écran de détail d'un signe LSF
class SignDetailScreen extends StatelessWidget {
  final SignModel sign;

  const SignDetailScreen({super.key, required this.sign});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = sign.category.color;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── AppBar avec illustration ──────────────────────────────────────
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor:
                isDark ? const Color(0xFF1A1625) : Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Vidéo LSF Wikimedia ou dessin de main en fallback
                  SignVideoPlayer(sign: sign, height: 240),
                  // Dégradé bas → nom du signe lisible
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            color.withValues(alpha: 0.55),
                          ],
                        ),
                      ),
                      child: Text(
                        sign.word,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                          shadows: [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Contenu ───────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge catégorie
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(sign.category.icon, size: 16, color: color),
                        const SizedBox(width: 6),
                        Text(
                          sign.category.label,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Comment réaliser le signe ─────────────────────────────
                  _SectionTitle(title: 'Comment réaliser ce signe', color: color),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2D2640)
                          : color.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: color.withValues(alpha: 0.20),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, color: color, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            sign.description,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Exemple d'utilisation ─────────────────────────────────
                  if (sign.usageExample != null) ...[
                    const SizedBox(height: 24),
                    _SectionTitle(title: 'Exemple', color: color),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2D2640)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Text('💬',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              sign.usageExample!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // ── Synonymes ─────────────────────────────────────────────
                  if (sign.synonyms.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _SectionTitle(title: 'Variantes & synonymes', color: color),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: sign.synonyms
                          .map((s) => Chip(
                                label: Text(s),
                                backgroundColor:
                                    color.withValues(alpha: 0.10),
                                labelStyle: TextStyle(color: color),
                                side: BorderSide.none,
                              ))
                          .toList(),
                    ),
                  ],

                  // ── Épellation manuelle ───────────────────────────────────
                  const SizedBox(height: 24),
                  _SectionTitle(
                      title: 'Épellation lettre par lettre', color: color),
                  const SizedBox(height: 10),
                  _FingerSpellRow(word: sign.word, color: color),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

/// Affiche les lettres d'un mot avec leur description en alphabet manuel
class _FingerSpellRow extends StatelessWidget {
  final String word;
  final Color color;

  const _FingerSpellRow({required this.word, required this.color});

  @override
  Widget build(BuildContext context) {
    final letters =
        word.toUpperCase().replaceAll(' ', '').split('');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: letters.map((letter) {
          final emoji = kFingerAlphabetEmoji[letter] ?? '✋';
          final desc = kFingerAlphabet[letter] ?? '';
          return Tooltip(
            message: desc,
            child: Container(
              width: 52,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                children: [
                  Text(emoji,
                      style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 4),
                  Text(
                    letter,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
