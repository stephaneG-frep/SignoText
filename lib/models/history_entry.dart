import 'dart:convert';
import 'sign_model.dart';
import 'translation_result.dart';

/// Une entrée dans l'historique des traductions
class HistoryEntry {
  final String id;

  /// Le texte original saisi par l'utilisateur
  final String inputText;

  /// La liste des résultats de traduction (un par mot)
  final List<TranslationResult> results;

  /// Date et heure de la traduction
  final DateTime timestamp;

  /// L'entrée est-elle marquée comme favori
  bool isFavorite;

  HistoryEntry({
    required this.id,
    required this.inputText,
    required this.results,
    required this.timestamp,
    this.isFavorite = false,
  });

  /// Nombre de mots trouvés
  int get foundCount => results.where((r) => r.isFound).length;

  /// Nombre de mots non trouvés
  int get notFoundCount => results.where((r) => !r.isFound).length;

  /// Pourcentage de mots traduits
  double get translationRate =>
      results.isEmpty ? 0.0 : foundCount / results.length;

  /// Sérialise l'entrée en JSON (uniquement les données nécessaires pour la persistance)
  Map<String, dynamic> toJson() => {
        'id': id,
        'inputText': inputText,
        'timestamp': timestamp.toIso8601String(),
        'isFavorite': isFavorite,
        // On stocke juste les mots trouvés et les originaux
        'resultSummary': results
            .map((r) => {
                  'originalWord': r.originalWord,
                  'found': r.isFound,
                  'signId': r.sign?.id,
                  'signWord': r.sign?.word,
                  'signEmoji': r.sign?.emoji,
                })
            .toList(),
      };

  String toJsonString() => jsonEncode(toJson());

  /// Reconstruit depuis JSON (version simplifiée pour l'historique)
  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    final resultSummary =
        List<Map<String, dynamic>>.from(json['resultSummary'] as List? ?? []);

    final results = resultSummary.map((r) {
      if (r['found'] == true && r['signId'] != null) {
        // On crée un SignModel minimal pour l'affichage dans l'historique
        final sign = SignModel(
          id: r['signId'] as String,
          word: r['signWord'] as String? ?? r['originalWord'] as String,
          category: SignCategory.divers,
          description: '',
          emoji: r['signEmoji'] as String? ?? '🤟',
        );
        return TranslationResult.found(sign,
            originalWord: r['originalWord'] as String);
      } else {
        return TranslationResult.notFound(r['originalWord'] as String);
      }
    }).toList();

    return HistoryEntry(
      id: json['id'] as String,
      inputText: json['inputText'] as String,
      results: results,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  factory HistoryEntry.fromJsonString(String jsonStr) =>
      HistoryEntry.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>);
}
