import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_entry.dart';

/// Service de persistance locale : historique et favoris
/// Utilise SharedPreferences pour un stockage simple et léger.
class StorageService {
  static const _historyKey = 'signotext_history';
  static const _maxHistorySize = 50;

  static final StorageService instance = StorageService._internal();
  factory StorageService() => instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _p async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // ─── HISTORIQUE ─────────────────────────────────────────────────────────────

  /// Charge tout l'historique depuis le stockage local
  Future<List<HistoryEntry>> loadHistory() async {
    final prefs = await _p;
    final raw = prefs.getStringList(_historyKey) ?? [];
    return raw
        .map((s) {
          try {
            return HistoryEntry.fromJsonString(s);
          } catch (_) {
            return null;
          }
        })
        .whereType<HistoryEntry>()
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  /// Sauvegarde une nouvelle entrée d'historique (ajoute en tête de liste)
  Future<void> saveHistoryEntry(HistoryEntry entry) async {
    final prefs = await _p;
    final entries = await loadHistory();

    // Déduplique : si le même texte existe déjà, le retirer
    entries.removeWhere((e) => e.inputText == entry.inputText);

    // Insérer en premier
    entries.insert(0, entry);

    // Limiter la taille
    final trimmed = entries.take(_maxHistorySize).toList();

    await prefs.setStringList(
      _historyKey,
      trimmed.map((e) => e.toJsonString()).toList(),
    );
  }

  /// Met à jour le statut favori d'une entrée
  Future<void> toggleFavorite(String entryId) async {
    final prefs = await _p;
    final entries = await loadHistory();
    final idx = entries.indexWhere((e) => e.id == entryId);
    if (idx == -1) return;

    entries[idx].isFavorite = !entries[idx].isFavorite;

    await prefs.setStringList(
      _historyKey,
      entries.map((e) => e.toJsonString()).toList(),
    );
  }

  /// Supprime une entrée de l'historique
  Future<void> deleteEntry(String entryId) async {
    final prefs = await _p;
    final entries = await loadHistory();
    entries.removeWhere((e) => e.id == entryId);
    await prefs.setStringList(
      _historyKey,
      entries.map((e) => e.toJsonString()).toList(),
    );
  }

  /// Efface tout l'historique
  Future<void> clearHistory() async {
    final prefs = await _p;
    await prefs.remove(_historyKey);
  }

  // ─── FAVORIS ─────────────────────────────────────────────────────────────────

  /// Retourne uniquement les entrées marquées comme favoris
  Future<List<HistoryEntry>> loadFavorites() async {
    final all = await loadHistory();
    return all.where((e) => e.isFavorite).toList();
  }

  // ─── PARAMÈTRES ──────────────────────────────────────────────────────────────

  Future<bool> getDarkMode() async {
    final prefs = await _p;
    return prefs.getBool('dark_mode') ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await _p;
    await prefs.setBool('dark_mode', value);
  }

  Future<bool> getFingerSpellDefault() async {
    final prefs = await _p;
    return prefs.getBool('finger_spell_default') ?? true;
  }

  Future<void> setFingerSpellDefault(bool value) async {
    final prefs = await _p;
    await prefs.setBool('finger_spell_default', value);
  }
}
