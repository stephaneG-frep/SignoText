import 'package:flutter/material.dart';

/// Catégories de signes disponibles dans le dictionnaire LSF
enum SignCategory {
  salutations,
  actions,
  lieux,
  pronoms,
  famille,
  nourriture,
  animaux,
  emotions,
  couleurs,
  chiffres,
  corps,
  temps,
  divers,
}

/// Extension pour afficher le nom et la couleur d'une catégorie
extension SignCategoryExtension on SignCategory {
  String get label {
    switch (this) {
      case SignCategory.salutations:
        return 'Salutations';
      case SignCategory.actions:
        return 'Actions';
      case SignCategory.lieux:
        return 'Lieux';
      case SignCategory.pronoms:
        return 'Pronoms';
      case SignCategory.famille:
        return 'Famille';
      case SignCategory.nourriture:
        return 'Nourriture';
      case SignCategory.animaux:
        return 'Animaux';
      case SignCategory.emotions:
        return 'Émotions';
      case SignCategory.couleurs:
        return 'Couleurs';
      case SignCategory.chiffres:
        return 'Chiffres';
      case SignCategory.corps:
        return 'Corps';
      case SignCategory.temps:
        return 'Temps';
      case SignCategory.divers:
        return 'Divers';
    }
  }

  Color get color {
    switch (this) {
      case SignCategory.salutations:
        return const Color(0xFF5E35B1);
      case SignCategory.actions:
        return const Color(0xFFE65100);
      case SignCategory.lieux:
        return const Color(0xFF2E7D32);
      case SignCategory.pronoms:
        return const Color(0xFF1565C0);
      case SignCategory.famille:
        return const Color(0xFFC62828);
      case SignCategory.nourriture:
        return const Color(0xFFFF8F00);
      case SignCategory.animaux:
        return const Color(0xFF00695C);
      case SignCategory.emotions:
        return const Color(0xFFAD1457);
      case SignCategory.couleurs:
        return const Color(0xFF6A1B9A);
      case SignCategory.chiffres:
        return const Color(0xFF00838F);
      case SignCategory.corps:
        return const Color(0xFF4E342E);
      case SignCategory.temps:
        return const Color(0xFF1976D2);
      case SignCategory.divers:
        return const Color(0xFF455A64);
    }
  }

  IconData get icon {
    switch (this) {
      case SignCategory.salutations:
        return Icons.waving_hand;
      case SignCategory.actions:
        return Icons.directions_run;
      case SignCategory.lieux:
        return Icons.place;
      case SignCategory.pronoms:
        return Icons.person;
      case SignCategory.famille:
        return Icons.family_restroom;
      case SignCategory.nourriture:
        return Icons.restaurant;
      case SignCategory.animaux:
        return Icons.pets;
      case SignCategory.emotions:
        return Icons.sentiment_satisfied;
      case SignCategory.couleurs:
        return Icons.palette;
      case SignCategory.chiffres:
        return Icons.tag;
      case SignCategory.corps:
        return Icons.accessibility_new;
      case SignCategory.temps:
        return Icons.access_time;
      case SignCategory.divers:
        return Icons.category;
    }
  }
}

/// Modèle représentant un signe LSF
class SignModel {
  final String id;

  /// Le mot en français
  final String word;

  /// Catégorie du signe
  final SignCategory category;

  /// Chemin vers l'image locale (optionnel, prévu pour plus tard)
  final String? imageAsset;

  /// URL vers une vidéo de démonstration (optionnel, prévu pour plus tard)
  final String? videoUrl;

  /// Description textuelle de comment réaliser le signe
  final String description;

  /// Emoji représentant visuellement le concept
  final String emoji;

  /// Mots synonymes ou variantes acceptées
  final List<String> synonyms;

  /// Exemple d'utilisation du signe en contexte
  final String? usageExample;

  const SignModel({
    required this.id,
    required this.word,
    required this.category,
    required this.description,
    required this.emoji,
    this.imageAsset,
    this.videoUrl,
    this.synonyms = const [],
    this.usageExample,
  });

  /// Sérialisation JSON pour la persistance
  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'category': category.name,
        'description': description,
        'emoji': emoji,
        'imageAsset': imageAsset,
        'videoUrl': videoUrl,
        'synonyms': synonyms,
        'usageExample': usageExample,
      };

  factory SignModel.fromJson(Map<String, dynamic> json) => SignModel(
        id: json['id'] as String,
        word: json['word'] as String,
        category: SignCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => SignCategory.divers,
        ),
        description: json['description'] as String,
        emoji: json['emoji'] as String,
        imageAsset: json['imageAsset'] as String?,
        videoUrl: json['videoUrl'] as String?,
        synonyms: List<String>.from(json['synonyms'] as List? ?? []),
        usageExample: json['usageExample'] as String?,
      );
}
