import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/sign_model.dart';
import '../services/wikimedia_service.dart';
import 'sign_illustration.dart';

/// Widget qui affiche la vidéo LSF d'un signe depuis Wikimedia Commons.
/// Affiche le dessin de main en attendant, puis la vidéo une fois chargée.
class SignVideoPlayer extends StatefulWidget {
  final SignModel sign;
  final double height;

  const SignVideoPlayer({
    super.key,
    required this.sign,
    this.height = 240,
  });

  @override
  State<SignVideoPlayer> createState() => _SignVideoPlayerState();
}

class _SignVideoPlayerState extends State<SignVideoPlayer> {
  VideoPlayerController? _controller;
  bool _loading = true;
  bool _hasVideo = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  Future<void> _loadVideo() async {
    final url = await WikimediaService.instance.findVideoUrl(widget.sign.word);
    debugPrint('[SignoText] Video URL for "${widget.sign.word}": $url');
    if (!mounted) return;

    if (url == null) {
      setState(() => _loading = false);
      return;
    }

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await controller.initialize();
      if (!mounted) {
        controller.dispose();
        return;
      }
      controller.setLooping(true);
      setState(() {
        _controller = controller;
        _hasVideo = true;
        _loading = false;
      });
    } catch (e) {
      debugPrint('[SignoText] Video init error: $e');
      controller.dispose();
      if (mounted) setState(() => _loading = false);
    }
  }

  void _togglePlay() {
    if (_controller == null) return;
    setState(() {
      if (_isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.sign.category.color;

    return SizedBox(
      height: widget.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Fond : vidéo ou dessin ───────────────────────────────────────
          if (_hasVideo && _controller != null)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            )
          else
            SignIllustration(sign: widget.sign, height: widget.height),

          // ── Chargement ───────────────────────────────────────────────────
          if (_loading)
            Container(
              color: color.withValues(alpha: 0.10),
              child: Center(
                child: CircularProgressIndicator(
                  color: color,
                  strokeWidth: 2.5,
                ),
              ),
            ),

          // ── Bouton play/pause ────────────────────────────────────────────
          if (_hasVideo && !_loading)
            Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                onTap: _togglePlay,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),

          // ── Badge "vidéo Wikimedia" ───────────────────────────────────────
          if (_hasVideo && !_loading)
            Positioned(
              top: 8,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.videocam, color: Colors.white, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'Elix · CC BY-SA',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),

          // ── Pas de vidéo disponible ──────────────────────────────────────
          if (!_loading && !_hasVideo)
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Illustration',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
