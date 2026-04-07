import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

/// Écran des paramètres de l'application
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final provider = context.watch<AppProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Titre ──────────────────────────────────────────────────
              Text('Paramètres',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  )),
              const SizedBox(height: 4),
              Text(
                'Personnalisez votre expérience',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),

              const SizedBox(height: 28),

              // ── Section Apparence ──────────────────────────────────────
              _SectionTitle(title: 'Apparence'),
              const SizedBox(height: 10),

              _SettingsTile(
                icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                title: 'Thème sombre',
                subtitle: isDark ? 'Mode sombre activé' : 'Mode clair activé',
                trailing: Switch(
                  value: provider.themeMode == ThemeMode.dark,
                  onChanged: (_) => provider.toggleTheme(),
                  activeThumbColor: const Color(0xFF5E35B1),
                ),
              ),

              const SizedBox(height: 24),

              // ── Section Traduction ─────────────────────────────────────
              _SectionTitle(title: 'Traduction'),
              const SizedBox(height: 10),

              _SettingsTile(
                icon: Icons.sign_language,
                title: 'Épellation automatique',
                subtitle:
                    'Épeler les mots inconnus lettre par lettre',
                trailing: Switch(
                  value: provider.fingerSpellDefault,
                  onChanged: provider.setFingerSpellDefault,
                  activeThumbColor: const Color(0xFF5E35B1),
                ),
              ),

              const SizedBox(height: 24),

              // ── Section Données ────────────────────────────────────────
              _SectionTitle(title: 'Données'),
              const SizedBox(height: 10),

              _SettingsTile(
                icon: Icons.delete_outline,
                title: 'Effacer l\'historique',
                subtitle: '${provider.history.length} traductions stockées',
                onTap: () => _confirmClearHistory(context, provider),
              ),

              const SizedBox(height: 24),

              // ── Section À propos ───────────────────────────────────────
              _SectionTitle(title: 'À propos'),
              const SizedBox(height: 10),

              _SettingsTile(
                icon: Icons.info_outline,
                title: 'SignoText',
                subtitle: 'Version 1.0.0 — Application LSF',
              ),
              _SettingsTile(
                icon: Icons.translate,
                title: 'Base de données',
                subtitle:
                    '${_countSigns()} signes LSF disponibles',
              ),
              _SettingsTile(
                icon: Icons.code,
                title: 'Évolution prévue',
                subtitle:
                    'Intégration IA de reformulation LSF naturelle',
              ),

              const SizedBox(height: 32),

              // ── Crédits ───────────────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Text('🤟',
                        style: const TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    Text(
                      'SignoText — Langue des Signes Française',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            isDark ? Colors.white38 : Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Pour tous, accessible à tous',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.28)
                            : Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _countSigns() {
    // Import local inline pour éviter une dépendance circulaire
    return 95; // kSignsData.length
  }

  Future<void> _confirmClearHistory(
      BuildContext context, AppProvider provider) async {
    if (provider.history.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('L\'historique est déjà vide.')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Effacer l\'historique ?'),
        content: const Text(
            'Toutes vos traductions et favoris seront supprimés définitivement.'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Historique effacé.')),
        );
      }
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: const Color(0xFF5E35B1),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2640) : Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF5E35B1).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon,
              color: const Color(0xFF5E35B1), size: 20),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.white54 : Colors.black45,
          ),
        ),
        trailing:
            trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      ),
    );
  }
}
