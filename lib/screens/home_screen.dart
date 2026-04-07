import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/signs_data.dart';
import '../providers/app_provider.dart';
import '../widgets/sign_card.dart';

/// Écran d'accueil : présentation de l'app et accès rapide
class HomeScreen extends StatelessWidget {
  final VoidCallback onGoToTranslation;

  const HomeScreen({super.key, required this.onGoToTranslation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ───────────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bonjour 👋',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bienvenue dans SignoText',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color:
                                isDark ? Colors.white54 : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Bouton thème rapide
                  Consumer<AppProvider>(
                    builder: (_, provider, _) => IconButton(
                      onPressed: provider.toggleTheme,
                      icon: Icon(
                        provider.themeMode == ThemeMode.dark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Bannière principale ───────────────────────────────────────
              _HeroBanner(onTap: onGoToTranslation),

              const SizedBox(height: 28),

              // ── Stats rapides ─────────────────────────────────────────────
              _StatsRow(),

              const SizedBox(height: 28),

              // ── Signes en vedette ─────────────────────────────────────────
              Text(
                'Signes du jour',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: kSignsData
                      .take(6)
                      .map((s) => SignCard(
                            sign: s,
                            originalWord: s.word,
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 28),

              // ── Conseil du jour ───────────────────────────────────────────
              _TipCard(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Bannière hero ────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _HeroBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5E35B1), Color(0xFF7E57C2)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5E35B1).withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Traduisez\nen LSF',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tapez une phrase et obtenez sa\ntraduction en Langue des Signes',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Commencer',
                          style: TextStyle(
                            color: Color(0xFF5E35B1),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward,
                            size: 16, color: Color(0xFF5E35B1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Text('🤟', style: TextStyle(fontSize: 72)),
          ],
        ),
      ),
    );
  }
}

// ─── Statistiques ─────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        _StatCard(
          emoji: '📚',
          value: '${kSignsData.length}',
          label: 'Signes',
          isDark: isDark,
        ),
        const SizedBox(width: 12),
        _StatCard(
          emoji: '🕐',
          value: '${provider.history.length}',
          label: 'Traductions',
          isDark: isDark,
        ),
        const SizedBox(width: 12),
        _StatCard(
          emoji: '⭐',
          value: '${provider.favorites.length}',
          label: 'Favoris',
          isDark: isDark,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final bool isDark;

  const _StatCard({
    required this.emoji,
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2D2640) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF5E35B1),
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Conseil du jour ──────────────────────────────────────────────────────────

class _TipCard extends StatelessWidget {
  static const _tips = [
    ('💡', 'Astuce', 'En LSF, l\'ordre des mots diffère du français. Sujet + Objet + Verbe est souvent utilisé.'),
    ('👁️', 'Le regard', 'Le regard est essentiel en LSF. Il indique la direction et l\'interlocuteur.'),
    ('😊', 'L\'expression', 'Les expressions faciales font partie intégrante de la grammaire LSF.'),
    ('🤝', 'Pratiquer', 'Pratiquez chaque signe lentement puis augmentez progressivement la fluidité.'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tip = _tips[DateTime.now().day % _tips.length];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2640) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF5E35B1).withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tip.$1, style: const TextStyle(fontSize: 30)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.$2,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF5E35B1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.$3,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
