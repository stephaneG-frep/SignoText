import 'package:flutter/material.dart';
import '../data/signs_data.dart';
import '../models/sign_model.dart';
import '../services/translation_service.dart';
import '../widgets/sign_card.dart';

/// Dictionnaire de signes consultable par catégorie et recherche libre
class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final _searchController = TextEditingController();
  SignCategory? _selectedCategory;
  List<SignModel> _results = kSignsData;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      _results = TranslationService.instance.searchDictionary(query);
      if (_selectedCategory != null) {
        _results =
            _results.where((s) => s.category == _selectedCategory).toList();
      }
    });
  }

  void _selectCategory(SignCategory? cat) {
    setState(() {
      _selectedCategory = (_selectedCategory == cat) ? null : cat;
      final query = _searchController.text;
      _results = TranslationService.instance.searchDictionary(query);
      if (_selectedCategory != null) {
        _results = _results
            .where((s) => s.category == _selectedCategory)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header + Recherche ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dictionnaire',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      )),
                  Text(
                    '${kSignsData.length} signes disponibles',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Barre de recherche
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Rechercher un signe...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged();
                              },
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Filtres par catégorie ────────────────────────────────────
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Chip "Tous"
                  _CategoryChip(
                    label: 'Tous',
                    icon: Icons.apps,
                    color: const Color(0xFF5E35B1),
                    isSelected: _selectedCategory == null,
                    onTap: () => _selectCategory(null),
                  ),
                  const SizedBox(width: 8),
                  ...SignCategory.values.map((cat) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _CategoryChip(
                          label: cat.label,
                          icon: cat.icon,
                          color: cat.color,
                          isSelected: _selectedCategory == cat,
                          onTap: () => _selectCategory(cat),
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Résultats ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${_results.length} résultat${_results.length > 1 ? 's' : ''}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white38 : Colors.black38,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 6),

            Expanded(
              child: _results.isEmpty
                  ? _EmptySearch(query: _searchController.text)
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: _results.length,
                      itemBuilder: (context, index) =>
                          SignCardVertical(sign: _results[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : (isDark
                  ? color.withValues(alpha: 0.15)
                  : color.withValues(alpha: 0.10)),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? color
                : color.withValues(alpha: 0.30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  final String query;

  const _EmptySearch({required this.query});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🔍', style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            'Aucun résultat pour "$query"',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
          ),
        ],
      ),
    );
  }
}
