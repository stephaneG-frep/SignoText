import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service qui interroge l'API Wikimedia Commons pour trouver
/// des vidéos LSF (projet Elix / Laura Jauvert) — licence CC BY-SA 4.0.
class WikimediaService {
  static final WikimediaService instance = WikimediaService._();
  WikimediaService._();

  static const _apiBase = 'https://commons.wikimedia.org/w/api.php';

  /// Cache mémoire : mot → URL vidéo (ou null si non trouvée)
  final Map<String, String?> _cache = {};

  /// Retourne l'URL directe d'une vidéo LSF pour un mot donné.
  /// Préfère le MP4 transcodé (ExoPlayer-friendly) au WebM natif.
  /// Retourne null si aucune vidéo n'est disponible.
  Future<String?> findVideoUrl(String word) async {
    final key = word.toLowerCase().trim();

    if (_cache.containsKey(key)) return _cache[key];

    // Essai 1 : recherche ciblée Elix + mot
    var url = await _searchFile(key, suffix: 'Elix');

    // Essai 2 : recherche Laura Jauvert
    url ??= await _searchFile(key, suffix: 'Laura_Jauvert');

    // Essai 3 : recherche générique LSF
    url ??= await _searchFile(key, suffix: null);

    _cache[key] = url;
    return url;
  }

  /// Interroge l'API de recherche Wikimedia Commons (namespace 6 = File)
  Future<String?> _searchFile(String word, {String? suffix}) async {
    try {
      final query = suffix != null
          ? '"$word" "$suffix"'
          : '"$word" "LSF" OR "fsl" OR "langue des signes"';

      final uri = Uri.parse(_apiBase).replace(queryParameters: {
        'action': 'query',
        'list': 'search',
        'srsearch': query,
        'srnamespace': '6',   // namespace File
        'srlimit': '5',
        'format': 'json',
        'origin': '*',
      });

      final response = await http.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = (data['query']?['search'] as List?) ?? [];

      for (final result in results) {
        final title = result['title'] as String? ?? '';
        // Garder seulement les fichiers vidéo
        if (!title.toLowerCase().endsWith('.webm') &&
            !title.toLowerCase().endsWith('.ogv')) {
          continue;
        }

        // Chercher d'abord un MP4 transcodé, sinon le WebM original
        final directUrl = await _getPreferredUrl(title);
        if (directUrl != null) return directUrl;
      }
    } catch (_) {}
    return null;
  }

  /// Récupère l'URL préférée pour un fichier : MP4 transcodé en priorité,
  /// puis WebM original. ExoPlayer lit le MP4 sans problème.
  Future<String?> _getPreferredUrl(String fileTitle) async {
    try {
      final uri = Uri.parse(_apiBase).replace(queryParameters: {
        'action': 'query',
        'titles': fileTitle,
        'prop': 'videoinfo',
        'viprop': 'url|derivatives',
        'format': 'json',
        'origin': '*',
      });

      final response = await http.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final pages = data['query']?['pages'] as Map<String, dynamic>? ?? {};

      for (final page in pages.values) {
        final vi = (page['videoinfo'] as List?)?.firstOrNull;
        if (vi == null) continue;

        // Chercher un dérivé MP4 (H.264) — compatible ExoPlayer sans bug
        final derivatives = vi['derivatives'] as List? ?? [];
        for (final d in derivatives) {
          final src = d['src'] as String? ?? '';
          if (src.toLowerCase().contains('.mp4')) {
            return src;
          }
        }

        // Fallback : URL WebM originale
        final url = vi['url'] as String?;
        if (url != null && url.isNotEmpty) return url;
      }
    } catch (_) {}
    return null;
  }
}
