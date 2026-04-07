import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/sign_model.dart';

/// Widget d'illustration d'un signe LSF.
/// Affiche l'asset image si disponible, sinon un dessin généré via CustomPainter.
class SignIllustration extends StatelessWidget {
  final SignModel sign;
  final double height;
  final bool showLabel;

  const SignIllustration({
    super.key,
    required this.sign,
    this.height = 120,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = sign.category.color;

    // Si une image est définie et existe en tant qu'asset → l'afficher
    if (sign.imageAsset != null) {
      return SizedBox(
        height: height,
        child: ClipRect(
          child: Image.asset(
            sign.imageAsset!,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _GeneratedIllustration(
              sign: sign,
              color: color,
              height: height,
            ),
          ),
        ),
      );
    }

    return _GeneratedIllustration(sign: sign, color: color, height: height);
  }
}

/// Illustration générée par CustomPainter selon la catégorie et le type de signe
class _GeneratedIllustration extends StatelessWidget {
  final SignModel sign;
  final Color color;
  final double height;

  const _GeneratedIllustration({
    required this.sign,
    required this.color,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.22),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _HandSignPainter(sign: sign, color: color),
        child: Stack(
          children: [
            // Cercle décoratif de fond
            Center(
              child: Container(
                width: height * 0.7,
                height: height * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.08),
                ),
              ),
            ),
            // Emoji principal (grand)
            Center(
              child: Text(
                sign.emoji,
                style: TextStyle(fontSize: height * 0.38),
              ),
            ),
            // Badge catégorie en bas à droite
            Positioned(
              bottom: 6,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(sign.category.icon, size: 14, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dessine des éléments décoratifs autour de l'emoji (points, lignes de mouvement)
class _HandSignPainter extends CustomPainter {
  final SignModel sign;
  final Color color;

  _HandSignPainter({required this.sign, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Dessin selon le type de signe (basé sur la catégorie)
    switch (sign.category) {
      case SignCategory.salutations:
        _drawWaveLines(canvas, paint, size);
      case SignCategory.actions:
        _drawMovementArrows(canvas, paint, dotPaint, cx, cy, size);
      case SignCategory.chiffres:
        _drawCirclePattern(canvas, paint, dotPaint, cx, cy, size);
      case SignCategory.couleurs:
        _drawColorDots(canvas, dotPaint, size, color);
      case SignCategory.corps:
        _drawBodyLines(canvas, paint, cx, cy, size);
      case SignCategory.temps:
        _drawClockArc(canvas, paint, cx, cy, size);
      default:
        _drawDotsPattern(canvas, dotPaint, size);
    }
  }

  /// Lignes ondulées (salutations - geste de la main)
  void _drawWaveLines(Canvas canvas, Paint paint, Size size) {
    final path = Path();
    for (var i = 0; i < 3; i++) {
      final y = size.height * (0.25 + i * 0.25);
      path.moveTo(8, y);
      for (var x = 8.0; x < size.width - 8; x += 16) {
        path.quadraticBezierTo(
          x + 8, y - 6,
          x + 16, y,
        );
      }
    }
    canvas.drawPath(path, paint);
  }

  /// Flèches de mouvement (actions)
  void _drawMovementArrows(Canvas canvas, Paint paint, Paint dotPaint,
      double cx, double cy, Size size) {
    // Arc de mouvement
    final rect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: size.width * 0.7,
      height: size.height * 0.7,
    );
    canvas.drawArc(rect, -math.pi * 0.8, math.pi * 0.6, false, paint);

    // Pointe de flèche
    final arrowPaint = Paint()
      ..color = color.withValues(alpha: 0.30)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final endX = cx + size.width * 0.27;
    final endY = cy - size.height * 0.15;
    canvas.drawLine(
        Offset(endX, endY), Offset(endX - 8, endY - 6), arrowPaint);
    canvas.drawLine(
        Offset(endX, endY), Offset(endX + 4, endY - 8), arrowPaint);
  }

  /// Cercle de points (chiffres)
  void _drawCirclePattern(Canvas canvas, Paint paint, Paint dotPaint,
      double cx, double cy, Size size) {
    final radius = size.width * 0.38;
    for (var i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * math.pi;
      final x = cx + radius * math.cos(angle);
      final y = cy + radius * math.sin(angle);
      canvas.drawCircle(Offset(x, y), 3, dotPaint);
    }
    canvas.drawCircle(Offset(cx, cy), radius, paint);
  }

  /// Points de couleur (catégorie couleurs)
  void _drawColorDots(
      Canvas canvas, Paint dotPaint, Size size, Color baseColor) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow.shade700,
      Colors.orange,
      Colors.purple,
    ];
    final positions = [
      Offset(size.width * 0.15, size.height * 0.2),
      Offset(size.width * 0.82, size.height * 0.2),
      Offset(size.width * 0.1, size.height * 0.75),
      Offset(size.width * 0.88, size.height * 0.75),
      Offset(size.width * 0.2, size.height * 0.5),
      Offset(size.width * 0.78, size.height * 0.5),
    ];
    for (var i = 0; i < colors.length; i++) {
      final p = Paint()
        ..color = colors[i].withValues(alpha: 0.35)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(positions[i], 5, p);
    }
  }

  /// Lignes verticales (corps)
  void _drawBodyLines(Canvas canvas, Paint paint, double cx, double cy,
      Size size) {
    // Ligne centrale verticale
    canvas.drawLine(
      Offset(cx, size.height * 0.1),
      Offset(cx, size.height * 0.9),
      paint,
    );
    // Ligne horizontale (épaules)
    canvas.drawLine(
      Offset(size.width * 0.25, cy),
      Offset(size.width * 0.75, cy),
      paint,
    );
  }

  /// Arc d'horloge (temps)
  void _drawClockArc(Canvas canvas, Paint paint, double cx, double cy,
      Size size) {
    final radius = size.width * 0.32;
    canvas.drawCircle(Offset(cx, cy), radius, paint);
    // Aiguilles
    final handPaint = Paint()
      ..color = color.withValues(alpha: 0.30)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    // Petite aiguille
    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + radius * 0.5 * math.cos(-math.pi / 2),
          cy + radius * 0.5 * math.sin(-math.pi / 2)),
      handPaint,
    );
    // Grande aiguille
    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + radius * 0.75 * math.cos(math.pi / 4),
          cy + radius * 0.75 * math.sin(math.pi / 4)),
      handPaint,
    );
  }

  /// Motif de points générique
  void _drawDotsPattern(Canvas canvas, Paint dotPaint, Size size) {
    final positions = [
      Offset(size.width * 0.15, size.height * 0.2),
      Offset(size.width * 0.82, size.height * 0.25),
      Offset(size.width * 0.12, size.height * 0.72),
      Offset(size.width * 0.85, size.height * 0.78),
    ];
    for (final pos in positions) {
      canvas.drawCircle(pos, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_HandSignPainter old) => old.sign.id != sign.id;
}
