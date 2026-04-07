import 'sign_model.dart';

/// Résultat de la traduction pour un mot individuel
class TranslationResult {
  /// Le mot original saisi par l'utilisateur
  final String originalWord;

  /// Le signe trouvé (null si non trouvé)
  final SignModel? sign;

  /// Indique si le signe a été trouvé dans la base
  final bool isFound;

  /// Liste de suggestions proches si le mot n'est pas trouvé
  final List<SignModel> suggestions;

  /// Si vrai, afficher l'épellation manuelle lettre par lettre
  final bool useFingerSpelling;

  const TranslationResult({
    required this.originalWord,
    this.sign,
    this.isFound = false,
    this.suggestions = const [],
    this.useFingerSpelling = false,
  });

  /// Résultat positif : signe trouvé
  factory TranslationResult.found(SignModel sign, {String? originalWord}) =>
      TranslationResult(
        originalWord: originalWord ?? sign.word,
        sign: sign,
        isFound: true,
      );

  /// Résultat négatif : mot non trouvé, avec suggestions éventuelles
  factory TranslationResult.notFound(
    String word, {
    List<SignModel> suggestions = const [],
    bool fingerSpell = true,
  }) =>
      TranslationResult(
        originalWord: word,
        isFound: false,
        suggestions: suggestions,
        useFingerSpelling: fingerSpell,
      );
}
