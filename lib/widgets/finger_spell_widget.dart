import 'package:flutter/material.dart';
import '../data/signs_data.dart';

/// Affiche l'épellation manuelle lettre par lettre d'un mot en LSF.
/// [compact] : version réduite pour les cartes horizontales.
class FingerSpellWidget extends StatelessWidget {
  final String word;
  final bool compact;

  const FingerSpellWidget({
    super.key,
    required this.word,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const color = Color(0xFF5E35B1);

    // Filtrer les espaces, mettre en majuscules
    final letters = word.toUpperCase().replaceAll(' ', '').split('');

    if (compact) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: letters.map((letter) {
            final emoji = kFingerAlphabetEmoji[letter] ?? '✋';
            return Tooltip(
              message: kFingerAlphabet[letter] ?? '',
              child: Container(
                width: 38,
                height: 46,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF3D3560)
                      : color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: color.withValues(alpha: 0.20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(emoji,
                        style: const TextStyle(fontSize: 18)),
                    Text(
                      letter,
                      style: TextStyle(
                        fontSize: 11,
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

    // Version complète avec description au tap
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Épellation : "${word.toUpperCase()}"',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: letters.map((letter) {
              final emoji = kFingerAlphabetEmoji[letter] ?? '✋';
              final desc = kFingerAlphabet[letter] ?? 'Lettre $letter';
              return _LetterTile(
                letter: letter,
                emoji: emoji,
                description: desc,
                color: color,
                isDark: isDark,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

/// Tuile interactive pour une lettre de l'alphabet manuel
class _LetterTile extends StatefulWidget {
  final String letter;
  final String emoji;
  final String description;
  final Color color;
  final bool isDark;

  const _LetterTile({
    required this.letter,
    required this.emoji,
    required this.description,
    required this.color,
    required this.isDark,
  });

  @override
  State<_LetterTile> createState() => _LetterTileState();
}

class _LetterTileState extends State<_LetterTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: _expanded ? 90 : 54,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: _expanded
              ? widget.color.withValues(alpha: 0.15)
              : (widget.isDark
                  ? const Color(0xFF3D3560)
                  : widget.color.withValues(alpha: 0.08)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.color.withValues(
                alpha: _expanded ? 0.50 : 0.20),
            width: _expanded ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.emoji,
                style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 4),
            Text(
              widget.letter,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: widget.color,
              ),
            ),
            if (_expanded) ...[
              const SizedBox(height: 6),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 9,
                  color: widget.isDark
                      ? Colors.white70
                      : Colors.black54,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
