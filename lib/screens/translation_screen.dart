import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/sign_card.dart';
import '../widgets/unknown_word_card.dart';

/// Écran principal de traduction texte → LSF
class TranslationScreen extends StatefulWidget {
  /// Texte pré-rempli (utilisé depuis l'historique)
  final String? initialText;

  const TranslationScreen({super.key, this.initialText});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText ?? '');
    // Si texte initial, lancer la traduction automatiquement
    if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AppProvider>().translate(widget.initialText!);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _translate() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _focusNode.unfocus();
    context.read<AppProvider>().translate(text);
    // Scroll vers les résultats
    Future.delayed(const Duration(milliseconds: 400), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          300,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void _clear() {
    _controller.clear();
    context.read<AppProvider>().clearTranslation();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Titre ────────────────────────────────────────────────────
              Text('Traduire',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  )),
              const SizedBox(height: 4),
              Text(
                'Saisissez une phrase pour la traduire en LSF',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
              ),
              const SizedBox(height: 24),

              // ── Champ de texte ───────────────────────────────────────────
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: 4,
                minLines: 2,
                textCapitalization: TextCapitalization.sentences,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText:
                      'Ex : Bonjour, je veux manger à la maison...',
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white30 : Colors.black26,
                  ),
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clear,
                          color: isDark
                              ? Colors.white38
                              : Colors.black38,
                        )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _translate(),
              ),
              const SizedBox(height: 16),

              // ── Boutons ──────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _translate,
                      icon: const Icon(Icons.translate, size: 20),
                      label: const Text('Traduire'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: _clear,
                    child: const Text('Effacer'),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── Résultats ────────────────────────────────────────────────
              Consumer<AppProvider>(
                builder: (context, provider, _) {
                  if (provider.isTranslating) {
                    return const _LoadingResults();
                  }
                  if (provider.currentResults.isEmpty) {
                    return const _EmptyState();
                  }
                  return _TranslationResults(
                    results: provider.currentResults,
                    inputText: provider.currentInput,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Résultats de traduction ─────────────────────────────────────────────────

class _TranslationResults extends StatelessWidget {
  final List<dynamic> results;
  final String inputText;

  const _TranslationResults(
      {required this.results, required this.inputText});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final foundCount = results.where((r) => r.isFound).length;
    final total = results.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Résumé ──────────────────────────────────────────────────────
        Row(
          children: [
            Text(
              'Résultats',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: foundCount == total
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.orange.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$foundCount/$total traduits',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: foundCount == total
                      ? Colors.green.shade700
                      : Colors.orange.shade700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Cartes horizontales des signes ───────────────────────────────
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              if (result.isFound && result.sign != null) {
                return SignCard(
                  sign: result.sign!,
                  originalWord: result.originalWord,
                );
              } else {
                return UnknownWordCard(result: result);
              }
            },
          ),
        ),

        const SizedBox(height: 24),

        // ── Légende ──────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF2D2640)
                : const Color(0xFFF0EDF8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.lightbulb_outline,
                  size: 18, color: Color(0xFF5E35B1)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Appuyez sur une carte pour voir le détail du signe et son épellation.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── États vides / chargement ────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text('🤟', style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'Tapez une phrase et appuyez\nsur "Traduire"',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
          ),
        ],
      ),
    );
  }
}

class _LoadingResults extends StatelessWidget {
  const _LoadingResults();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          CircularProgressIndicator(
            color: Color(0xFF5E35B1),
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text('Traduction en cours...'),
        ],
      ),
    );
  }
}
