import '../data/signs_data.dart';
import '../models/sign_model.dart';
import '../models/translation_result.dart';

/// Service de traduction : normalise le texte, recherche les signes LSF,
/// et gère les mots inconnus avec suggestions ou épellation manuelle.
///
/// Structure évolutive : ce service peut être connecté à une IA de reformulation
/// LSF (ex. GPT-4) en remplaçant [translate] par un appel réseau.
class TranslationService {
  static final TranslationService _instance = TranslationService._internal();
  factory TranslationService() => _instance;
  TranslationService._internal();

  /// Index de recherche rapide : mot normalisé → SignModel
  late final Map<String, SignModel> _index;

  /// Index des synonymes : synonyme normalisé → SignModel
  late final Map<String, SignModel> _synonymIndex;

  TranslationService._init() {
    _buildIndex();
  }

  static final TranslationService instance = TranslationService._init();

  void _buildIndex() {
    _index = {};
    _synonymIndex = {};
    for (final sign in kSignsData) {
      _index[_normalize(sign.word)] = sign;
      for (final synonym in sign.synonyms) {
        _synonymIndex[_normalize(synonym)] = sign;
      }
    }
  }

  /// Normalise un mot : minuscules, suppression des accents, trim
  String _normalize(String text) {
    var result = text.toLowerCase().trim();
    // Suppression des accents courants
    const accents = {
      'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
      'à': 'a', 'â': 'a', 'ä': 'a',
      'ù': 'u', 'û': 'u', 'ü': 'u',
      'î': 'i', 'ï': 'i',
      'ô': 'o', 'ö': 'o',
      'ç': 'c',
    };
    for (final entry in accents.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  /// Découpe une phrase en mots significatifs (retire ponctuation et mots vides courts)
  List<String> splitIntoWords(String text) {
    // Supprimer la ponctuation
    final cleaned = text.replaceAll(RegExp(r'[^\w\s]'), ' ');
    return cleaned
        .split(RegExp(r'\s+'))
        .map((w) => w.trim())
        .where((w) => w.isNotEmpty)
        .toList();
  }

  /// Recherche un signe exact par mot
  SignModel? findSign(String word) {
    final key = _normalize(word);
    return _index[key] ?? _synonymIndex[key];
  }

  /// Recherche des signes proches par similarité de chaîne (distance de Levenshtein simplifiée)
  List<SignModel> findSuggestions(String word, {int maxSuggestions = 3}) {
    final key = _normalize(word);
    final scored = <MapEntry<SignModel, int>>[];

    for (final entry in _index.entries) {
      final dist = _levenshtein(key, entry.key);
      if (dist <= 3) {
        scored.add(MapEntry(entry.value, dist));
      }
    }

    scored.sort((a, b) => a.value.compareTo(b.value));
    return scored.take(maxSuggestions).map((e) => e.key).toList();
  }

  /// Traduit une phrase complète en liste de résultats
  List<TranslationResult> translate(String inputText) {
    final words = splitIntoWords(inputText);
    if (words.isEmpty) return [];

    final results = <TranslationResult>[];

    for (final word in words) {
      final sign = findSign(word);
      if (sign != null) {
        results.add(TranslationResult.found(sign, originalWord: word));
      } else {
        // Chercher des suggestions proches
        final suggestions = findSuggestions(word);
        results.add(TranslationResult.notFound(
          word,
          suggestions: suggestions,
          fingerSpell: true,
        ));
      }
    }

    return results;
  }

  /// Distance de Levenshtein simplifiée pour les suggestions
  int _levenshtein(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    final m = s.length;
    final n = t.length;
    final dp = List.generate(m + 1, (i) => List.filled(n + 1, 0));

    for (var i = 0; i <= m; i++) { dp[i][0] = i; }
    for (var j = 0; j <= n; j++) { dp[0][j] = j; }

    for (var i = 1; i <= m; i++) {
      for (var j = 1; j <= n; j++) {
        if (s[i - 1] == t[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 +
              [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]]
                  .reduce((a, b) => a < b ? a : b);
        }
      }
    }

    return dp[m][n];
  }

  /// Récupère tous les signes d'une catégorie
  List<SignModel> getSignsByCategory(SignCategory category) {
    return kSignsData.where((s) => s.category == category).toList();
  }

  /// Recherche dans le dictionnaire par terme libre
  List<SignModel> searchDictionary(String query) {
    if (query.trim().isEmpty) return kSignsData;
    final key = _normalize(query);
    return kSignsData.where((sign) {
      return _normalize(sign.word).contains(key) ||
          sign.synonyms.any((s) => _normalize(s).contains(key)) ||
          _normalize(sign.description).contains(key);
    }).toList();
  }
}
