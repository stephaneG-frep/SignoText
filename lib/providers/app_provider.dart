import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/history_entry.dart';
import '../models/translation_result.dart';
import '../services/storage_service.dart';
import '../services/translation_service.dart';

/// État global de l'application via ChangeNotifier (Provider)
class AppProvider extends ChangeNotifier {
  final _translationService = TranslationService.instance;
  final _storageService = StorageService.instance;
  final _uuid = const Uuid();

  // ─── Thème ──────────────────────────────────────────────────────────────────
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  // ─── Traduction en cours ─────────────────────────────────────────────────────
  List<TranslationResult> _currentResults = [];
  List<TranslationResult> get currentResults => _currentResults;

  String _currentInput = '';
  String get currentInput => _currentInput;

  bool _isTranslating = false;
  bool get isTranslating => _isTranslating;

  // ─── Historique & Favoris ────────────────────────────────────────────────────
  List<HistoryEntry> _history = [];
  List<HistoryEntry> get history => _history;

  List<HistoryEntry> get favorites =>
      _history.where((e) => e.isFavorite).toList();

  // ─── Paramètres ──────────────────────────────────────────────────────────────
  bool _fingerSpellDefault = true;
  bool get fingerSpellDefault => _fingerSpellDefault;

  // ─── Initialisation ──────────────────────────────────────────────────────────
  Future<void> init() async {
    _history = await _storageService.loadHistory();
    final dark = await _storageService.getDarkMode();
    _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    _fingerSpellDefault = await _storageService.getFingerSpellDefault();
    notifyListeners();
  }

  // ─── Traduction ──────────────────────────────────────────────────────────────

  /// Lance la traduction de la phrase saisie
  Future<void> translate(String text) async {
    if (text.trim().isEmpty) return;

    _isTranslating = true;
    _currentInput = text.trim();
    _currentResults = [];
    notifyListeners();

    // Légère pause pour l'animation de chargement
    await Future.delayed(const Duration(milliseconds: 300));

    _currentResults = _translationService.translate(text);
    _isTranslating = false;
    notifyListeners();

    // Sauvegarder dans l'historique
    if (_currentResults.isNotEmpty) {
      final entry = HistoryEntry(
        id: _uuid.v4(),
        inputText: _currentInput,
        results: _currentResults,
        timestamp: DateTime.now(),
      );
      await _storageService.saveHistoryEntry(entry);
      _history = await _storageService.loadHistory();
      notifyListeners();
    }
  }

  /// Efface la traduction en cours
  void clearTranslation() {
    _currentResults = [];
    _currentInput = '';
    notifyListeners();
  }

  // ─── Historique ──────────────────────────────────────────────────────────────

  Future<void> toggleFavorite(String entryId) async {
    await _storageService.toggleFavorite(entryId);
    _history = await _storageService.loadHistory();
    notifyListeners();
  }

  Future<void> deleteHistoryEntry(String entryId) async {
    await _storageService.deleteEntry(entryId);
    _history = await _storageService.loadHistory();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    await _storageService.clearHistory();
    _history = [];
    notifyListeners();
  }

  // ─── Paramètres ──────────────────────────────────────────────────────────────

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _storageService.setDarkMode(_themeMode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _storageService.setDarkMode(mode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> setFingerSpellDefault(bool value) async {
    _fingerSpellDefault = value;
    await _storageService.setFingerSpellDefault(value);
    notifyListeners();
  }
}
