import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/sign_model.dart';

// ─── Formes de main LSF ──────────────────────────────────────────────────────

/// Configurations de doigts pour les formes de main courantes en LSF.
/// Ordre : [pouce, index, majeur, annulaire, auriculaire]
/// true = tendu/levé, false = plié/replié
enum HandShape {
  flatHand,    // B : main plate, doigts joints
  openHand,    // 5 : main ouverte, doigts écartés
  fist,        // A : poing fermé
  indexUp,     // 1 : index tendu seul
  vSign,       // V : index + majeur
  threeUp,     // 3 : index + majeur + annulaire
  fourUp,      // 4 : 4 doigts tendus
  cShape,      // C : main courbée en C
  okShape,     // O/F : pouce + index formant un cercle
  thumbUp,     // pouce levé
  yShape,      // Y : pouce + auriculaire
  lShape,      // L : index + pouce perpendiculaires
  pinch,       // pince : pouce + index rapprochés
  wavingHand,  // main ouverte en mouvement (salutation)
}

/// Correspondance signe LSF → forme de main
const Map<String, HandShape> _signHandShapes = {
  // Salutations
  'bonjour':       HandShape.wavingHand,
  'merci':         HandShape.flatHand,
  'au_revoir':     HandShape.wavingHand,
  'sil_vous_plait':HandShape.flatHand,
  'oui':           HandShape.thumbUp,
  'non':           HandShape.vSign,
  // Pronoms
  'je':            HandShape.indexUp,
  'toi':           HandShape.indexUp,
  'nous':          HandShape.indexUp,
  'il':            HandShape.indexUp,
  // Actions
  'manger':        HandShape.pinch,
  'boire':         HandShape.cShape,
  'aider':         HandShape.flatHand,
  'voir':          HandShape.vSign,
  'comprendre':    HandShape.indexUp,
  'parler':        HandShape.indexUp,
  'aimer':         HandShape.fist,
  'jouer':         HandShape.yShape,
  'dormir':        HandShape.flatHand,
  'courir':        HandShape.vSign,
  'vouloir':       HandShape.openHand,
  'aller':         HandShape.indexUp,
  'venir':         HandShape.indexUp,
  'donner':        HandShape.flatHand,
  'attendre':      HandShape.openHand,
  'travail':       HandShape.fist,
  'apprendre':     HandShape.flatHand,
  // Lieux
  'maison':        HandShape.flatHand,
  'ecole':         HandShape.flatHand,
  'hopital':       HandShape.indexUp,
  'magasin':       HandShape.flatHand,
  'restaurant':    HandShape.pinch,
  'ville':         HandShape.flatHand,
  'jardin':        HandShape.openHand,
  // Famille
  'famille':       HandShape.openHand,
  'mere':          HandShape.thumbUp,
  'pere':          HandShape.thumbUp,
  'frere':         HandShape.indexUp,
  'soeur':         HandShape.indexUp,
  'grand_mere':    HandShape.thumbUp,
  'grand_pere':    HandShape.thumbUp,
  'enfant':        HandShape.flatHand,
  'ami':           HandShape.indexUp,
  // Nourriture
  'eau':           HandShape.threeUp,
  'pain':          HandShape.cShape,
  'pomme':         HandShape.fist,
  'lait':          HandShape.fist,
  'cafe':          HandShape.indexUp,
  'the':           HandShape.pinch,
  'viande':        HandShape.pinch,
  'legume':        HandShape.lShape,
  'fruit':         HandShape.okShape,
  'gateau':        HandShape.flatHand,
  'chocolat':      HandShape.indexUp,
  // Animaux
  'chat':          HandShape.pinch,
  'chien':         HandShape.openHand,
  'oiseau':        HandShape.pinch,
  'lapin':         HandShape.vSign,
  'poisson':       HandShape.flatHand,
  // Émotions
  'content':       HandShape.flatHand,
  'triste':        HandShape.openHand,
  'fatigue':       HandShape.openHand,
  'malade':        HandShape.indexUp,
  'peur':          HandShape.openHand,
  'beau':          HandShape.flatHand,
  // Couleurs
  'rouge':         HandShape.indexUp,
  'bleu':          HandShape.flatHand,
  'vert':          HandShape.vSign,
  'jaune':         HandShape.yShape,
  'blanc':         HandShape.openHand,
  'noir':          HandShape.indexUp,
  'orange':        HandShape.fist,
  'rose':          HandShape.indexUp,
  'violet':        HandShape.vSign,
  // Chiffres
  'un':            HandShape.indexUp,
  'deux':          HandShape.vSign,
  'trois':         HandShape.threeUp,
  'quatre':        HandShape.fourUp,
  'cinq':          HandShape.openHand,
  'dix':           HandShape.openHand,
  'cent':          HandShape.cShape,
  // Corps
  'tete':          HandShape.indexUp,
  'main':          HandShape.flatHand,
  'yeux':          HandShape.vSign,
  'bouche':        HandShape.indexUp,
  'oreille':       HandShape.pinch,
  'coeur':         HandShape.fist,
  // Temps
  "aujourd_hui":   HandShape.indexUp,
  'demain':        HandShape.flatHand,
  'hier':          HandShape.flatHand,
  'matin':         HandShape.flatHand,
  'soir':          HandShape.flatHand,
  'maintenant':    HandShape.flatHand,
  'heure':         HandShape.indexUp,
  'semaine':       HandShape.indexUp,
  // Divers
  'telephone':     HandShape.yShape,
  'argent':        HandShape.fist,
  'probleme':      HandShape.indexUp,
  'question':      HandShape.indexUp,
  'voiture':       HandShape.openHand,
};

// ─── Widget principal ────────────────────────────────────────────────────────

/// Illustration d'un signe LSF.
/// Priorité : asset image réelle > dessin de main généré
class SignIllustration extends StatelessWidget {
  final SignModel sign;
  final double height;

  const SignIllustration({
    super.key,
    required this.sign,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    final color = sign.category.color;

    if (sign.imageAsset != null) {
      return SizedBox(
        height: height,
        child: Image.asset(
          sign.imageAsset!,
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) =>
              _HandIllustration(sign: sign, color: color, height: height),
        ),
      );
    }

    return _HandIllustration(sign: sign, color: color, height: height);
  }
}

// ─── Illustration de main ────────────────────────────────────────────────────

class _HandIllustration extends StatelessWidget {
  final SignModel sign;
  final Color color;
  final double height;

  const _HandIllustration({
    required this.sign,
    required this.color,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final shape = _signHandShapes[sign.id] ?? _defaultShape(sign.category);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.08),
            color.withValues(alpha: 0.18),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _HandPainter(shape: shape, color: color),
      ),
    );
  }

  HandShape _defaultShape(SignCategory cat) {
    switch (cat) {
      case SignCategory.salutations: return HandShape.wavingHand;
      case SignCategory.actions:     return HandShape.openHand;
      case SignCategory.chiffres:    return HandShape.indexUp;
      case SignCategory.couleurs:    return HandShape.flatHand;
      case SignCategory.corps:       return HandShape.flatHand;
      case SignCategory.temps:       return HandShape.indexUp;
      case SignCategory.famille:     return HandShape.thumbUp;
      case SignCategory.nourriture:  return HandShape.pinch;
      case SignCategory.animaux:     return HandShape.pinch;
      case SignCategory.emotions:    return HandShape.openHand;
      case SignCategory.lieux:       return HandShape.flatHand;
      case SignCategory.pronoms:     return HandShape.indexUp;
      case SignCategory.divers:      return HandShape.openHand;
    }
  }
}

// ─── Dessin de la main ───────────────────────────────────────────────────────

class _HandPainter extends CustomPainter {
  final HandShape shape;
  final Color color;

  _HandPainter({required this.shape, required this.color});

  // Couleurs
  late Paint _skinFill;
  late Paint _skinStroke;

  late Paint _arrowPaint;

  @override
  void paint(Canvas canvas, Size size) {
    _skinFill = Paint()
      ..color = color.withValues(alpha: 0.28)
      ..style = PaintingStyle.fill;

    _skinStroke = Paint()
      ..color = color.withValues(alpha: 0.70)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;


    _arrowPaint = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.save();

    // Centrer le dessin
    final cx = size.width / 2;
    final cy = size.height / 2;

    switch (shape) {
      case HandShape.flatHand:
        _drawFlatHand(canvas, cx, cy, size);
      case HandShape.openHand:
        _drawOpenHand(canvas, cx, cy, size);
      case HandShape.fist:
        _drawFist(canvas, cx, cy, size);
      case HandShape.indexUp:
        _drawIndexUp(canvas, cx, cy, size);
      case HandShape.vSign:
        _drawVSign(canvas, cx, cy, size);
      case HandShape.threeUp:
        _drawThreeUp(canvas, cx, cy, size);
      case HandShape.fourUp:
        _drawFourUp(canvas, cx, cy, size);
      case HandShape.cShape:
        _drawCShape(canvas, cx, cy, size);
      case HandShape.okShape:
        _drawOkShape(canvas, cx, cy, size);
      case HandShape.thumbUp:
        _drawThumbUp(canvas, cx, cy, size);
      case HandShape.yShape:
        _drawYShape(canvas, cx, cy, size);
      case HandShape.lShape:
        _drawLShape(canvas, cx, cy, size);
      case HandShape.pinch:
        _drawPinch(canvas, cx, cy, size);
      case HandShape.wavingHand:
        _drawWavingHand(canvas, cx, cy, size);
    }

    canvas.restore();
  }

  // ── Utilitaires ─────────────────────────────────────────────────────────────

  /// Dessine un doigt (rectangle arrondi)
  void _drawFinger(Canvas canvas, double x, double y, double w, double h,
      {bool filled = true}) {
    final rr = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(x, y - h / 2), width: w, height: h),
      Radius.circular(w / 2),
    );
    if (filled) canvas.drawRRect(rr, _skinFill);
    canvas.drawRRect(rr, _skinStroke);
  }

  /// Dessine la paume (rectangle arrondi)
  void _drawPalm(Canvas canvas, double cx, double cy, double w, double h) {
    final rr = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy + h * 0.1), width: w, height: h),
      Radius.circular(w * 0.2),
    );
    canvas.drawRRect(rr, _skinFill);
    canvas.drawRRect(rr, _skinStroke);
  }

  /// Dessine une flèche simple
  void _drawArrow(Canvas canvas, Offset from, Offset to) {
    canvas.drawLine(from, to, _arrowPaint);
    final angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    const arrowSize = 8.0;
    canvas.drawLine(
      to,
      to + Offset(math.cos(angle - 2.5) * arrowSize,
          math.sin(angle - 2.5) * arrowSize),
      _arrowPaint,
    );
    canvas.drawLine(
      to,
      to + Offset(math.cos(angle + 2.5) * arrowSize,
          math.sin(angle + 2.5) * arrowSize),
      _arrowPaint,
    );
  }

  // ── Formes de main ───────────────────────────────────────────────────────────

  /// B : main plate, doigts joints
  void _drawFlatHand(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 44 * scale;
    final palmH = 34 * scale;
    final palmCy = cy + 16 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    final fingerW = 9 * scale;
    final fingerH = 38 * scale;
    final tops = [cx - 15 * scale, cx - 5 * scale, cx + 5 * scale, cx + 15 * scale];
    final topY = palmCy - palmH / 2;
    for (final fx in tops) {
      _drawFinger(canvas, fx, topY, fingerW, fingerH);
    }
    // Pouce (côté gauche, plus court, incliné)
    _drawFinger(canvas, cx - 26 * scale, palmCy, 8 * scale, 20 * scale);
  }

  /// 5 : main ouverte, doigts écartés
  void _drawOpenHand(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 48 * scale;
    final palmH = 32 * scale;
    final palmCy = cy + 14 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    final fingerW = 9 * scale;
    final positions = [
      (cx - 18 * scale, 36 * scale),
      (cx - 6 * scale,  40 * scale),
      (cx + 5 * scale,  40 * scale),
      (cx + 17 * scale, 36 * scale),
    ];
    final topY = palmCy - palmH / 2;
    for (final (fx, fh) in positions) {
      _drawFinger(canvas, fx, topY, fingerW, fh);
    }
    // Pouce écarté
    _drawFinger(canvas, cx - 30 * scale, palmCy + 4 * scale, 8 * scale, 18 * scale);
  }

  /// A : poing fermé
  void _drawFist(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final fistW = 48 * scale;
    final fistH = 42 * scale;
    // Poing = grand rectangle arrondi
    final rr = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy + 4 * scale), width: fistW, height: fistH),
      Radius.circular(10 * scale),
    );
    canvas.drawRRect(rr, _skinFill);
    canvas.drawRRect(rr, _skinStroke);

    // Ligne des phalanges
    final knucklePaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final ky = cy - 8 * scale;
    for (var i = 0; i < 4; i++) {
      final kx = cx - 15 * scale + i * 10 * scale;
      canvas.drawArc(
        Rect.fromCenter(center: Offset(kx, ky), width: 10 * scale, height: 6 * scale),
        math.pi, math.pi, false, knucklePaint,
      );
    }
    // Pouce côté
    _drawFinger(canvas, cx - 28 * scale, cy + 6 * scale, 8 * scale, 16 * scale);
  }

  /// 1 : index seul tendu
  void _drawIndexUp(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 44 * scale;
    final palmH = 32 * scale;
    final palmCy = cy + 16 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    // Index levé (plus haut)
    final topY = palmCy - palmH / 2;
    _drawFinger(canvas, cx - 4 * scale, topY, 10 * scale, 46 * scale);

    // Autres doigts repliés (petits)
    final foldedW = 9 * scale;
    final foldedH = 12 * scale;
    _drawFinger(canvas, cx + 6 * scale,  palmCy - palmH / 2 + foldedH / 2, foldedW, foldedH);
    _drawFinger(canvas, cx + 15 * scale, palmCy - palmH / 2 + foldedH / 2, foldedW, foldedH);
    _drawFinger(canvas, cx - 14 * scale, palmCy - palmH / 2 + foldedH / 2, foldedW, foldedH);

    // Flèche de mouvement vers le haut
    _drawArrow(canvas,
      Offset(cx + 20 * scale, topY - 8 * scale),
      Offset(cx + 20 * scale, topY - 24 * scale),
    );
  }

  /// V : index + majeur
  void _drawVSign(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 44 * scale;
    final palmH = 30 * scale;
    final palmCy = cy + 18 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    final topY = palmCy - palmH / 2;
    _drawFinger(canvas, cx - 8 * scale, topY, 10 * scale, 44 * scale);
    _drawFinger(canvas, cx + 4 * scale,  topY, 10 * scale, 44 * scale);

    // Replié
    final foldedH = 12 * scale;
    _drawFinger(canvas, cx + 15 * scale, palmCy - palmH / 2 + foldedH / 2, 9 * scale, foldedH);
    _drawFinger(canvas, cx - 18 * scale, palmCy - palmH / 2 + foldedH / 2, 9 * scale, foldedH);
  }

  /// 3 : index + majeur + annulaire
  void _drawThreeUp(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 46 * scale;
    final palmH = 30 * scale;
    final palmCy = cy + 16 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    final topY = palmCy - palmH / 2;
    final fingerW = 10 * scale;
    _drawFinger(canvas, cx - 12 * scale, topY, fingerW, 40 * scale);
    _drawFinger(canvas, cx,             topY, fingerW, 44 * scale);
    _drawFinger(canvas, cx + 12 * scale, topY, fingerW, 40 * scale);

    // Replié
    final foldedH = 12 * scale;
    _drawFinger(canvas, cx + 22 * scale, palmCy - palmH / 2 + foldedH / 2, 9 * scale, foldedH);
  }

  /// 4 : 4 doigts tendus
  void _drawFourUp(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 46 * scale;
    final palmH = 30 * scale;
    final palmCy = cy + 16 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    final topY = palmCy - palmH / 2;
    final fingerW = 9 * scale;
    for (var i = 0; i < 4; i++) {
      _drawFinger(canvas, cx - 15 * scale + i * 10 * scale, topY, fingerW, 40 * scale);
    }
    // Pouce replié
    final foldedH = 14 * scale;
    _drawFinger(canvas, cx - 26 * scale, palmCy - palmH / 2 + foldedH / 2, 8 * scale, foldedH);
  }

  /// C : main courbée
  void _drawCShape(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final path = Path();
    final r = 28 * scale;

    // Arc de C (demi-cercle ouvert à droite)
    path.addArc(
      Rect.fromCenter(center: Offset(cx - 6 * scale, cy), width: r * 2, height: r * 1.6),
      math.pi * 0.25,
      math.pi * 1.5,
    );
    final cPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14 * scale
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, cPaint);
    canvas.drawPath(path, _skinStroke..strokeWidth = 2);
  }

  /// O/F : pouce + index en cercle
  void _drawOkShape(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    // Cercle (pouce + index)
    final circleR = 16 * scale;
    final circleCy = cy + 8 * scale;
    canvas.drawCircle(Offset(cx, circleCy), circleR, _skinFill);
    canvas.drawCircle(Offset(cx, circleCy), circleR, _skinStroke);

    // Autres doigts tendus vers le haut
    final fingerW = 9 * scale;
    final tops = [cx - 6 * scale, cx + 4 * scale, cx + 14 * scale];
    final topY = circleCy - circleR;
    for (final fx in tops) {
      _drawFinger(canvas, fx, topY, fingerW, 36 * scale);
    }
  }

  /// Pouce levé
  void _drawThumbUp(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 40 * scale;
    final palmH = 36 * scale;
    final palmCy = cy + 10 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    // Pouce tendu vers le haut
    _drawFinger(canvas, cx - 22 * scale, palmCy - 12 * scale, 11 * scale, 36 * scale);

    // 4 doigts repliés
    final foldedH = 13 * scale;
    for (var i = 0; i < 4; i++) {
      _drawFinger(canvas, cx - 14 * scale + i * 10 * scale,
          palmCy - palmH / 2 + foldedH / 2, 9 * scale, foldedH);
    }
  }

  /// Y : pouce + auriculaire
  void _drawYShape(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 44 * scale;
    final palmH = 30 * scale;
    final palmCy = cy + 14 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    final topY = palmCy - palmH / 2;
    // Auriculaire (droite)
    _drawFinger(canvas, cx + 18 * scale, topY, 9 * scale, 36 * scale);
    // Pouce (gauche)
    _drawFinger(canvas, cx - 28 * scale, palmCy, 9 * scale, 28 * scale);

    // Index, majeur, annulaire repliés
    final foldedH = 12 * scale;
    for (var i = 0; i < 3; i++) {
      _drawFinger(canvas, cx - 12 * scale + i * 10 * scale,
          palmCy - palmH / 2 + foldedH / 2, 9 * scale, foldedH);
    }
  }

  /// L : index + pouce (angle droit)
  void _drawLShape(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 36 * scale;
    final palmH = 30 * scale;
    final palmCy = cy + 16 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    // Index vers le haut
    _drawFinger(canvas, cx, palmCy - palmH / 2, 10 * scale, 44 * scale);
    // Pouce horizontal (gauche)
    _drawFinger(canvas, cx - 28 * scale, palmCy - 8 * scale, 24 * scale, 9 * scale);

    // Autres doigts repliés
    final foldedH = 12 * scale;
    for (var i = 0; i < 3; i++) {
      _drawFinger(canvas, cx + 8 * scale + i * 9 * scale,
          palmCy - palmH / 2 + foldedH / 2, 8 * scale, foldedH);
    }
  }

  /// Pince : pouce + index rapprochés
  void _drawPinch(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;
    final palmW = 40 * scale;
    final palmH = 28 * scale;
    final palmCy = cy + 16 * scale;
    _drawPalm(canvas, cx, palmCy, palmW, palmH);

    final topY = palmCy - palmH / 2;
    // Index courbé vers le pouce
    _drawFinger(canvas, cx - 4 * scale, topY, 10 * scale, 28 * scale);
    // Pouce qui monte vers l'index
    final thumbPath = Path();
    thumbPath.moveTo(cx - 24 * scale, palmCy + 4 * scale);
    thumbPath.quadraticBezierTo(
      cx - 24 * scale, topY + 8 * scale,
      cx - 12 * scale, topY + 2 * scale,
    );
    thumbPath.lineTo(cx - 8 * scale, topY + 6 * scale);
    thumbPath.quadraticBezierTo(
      cx - 16 * scale, topY + 14 * scale,
      cx - 20 * scale, palmCy + 4 * scale,
    );
    thumbPath.close();
    canvas.drawPath(thumbPath, _skinFill);
    canvas.drawPath(thumbPath, _skinStroke);

    // Autres doigts repliés
    final foldedH = 12 * scale;
    for (var i = 0; i < 3; i++) {
      _drawFinger(canvas, cx + 6 * scale + i * 10 * scale,
          palmCy - palmH / 2 + foldedH / 2, 9 * scale, foldedH);
    }
  }

  /// Main ouverte avec arc de mouvement (salutation)
  void _drawWavingHand(Canvas canvas, double cx, double cy, Size s) {
    final scale = s.height / 120;

    // Légèrement inclinée
    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(-0.2);
    canvas.translate(-cx, -cy);

    _drawOpenHand(canvas, cx, cy, s);
    canvas.restore();

    // Arc de mouvement
    final arcRect = Rect.fromCenter(
      center: Offset(cx + 32 * scale, cy - 10 * scale),
      width: 30 * scale,
      height: 50 * scale,
    );
    final arcPaint = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawArc(arcRect, -math.pi * 0.8, math.pi * 1.0, false, arcPaint);
    _drawArrow(canvas,
      Offset(cx + 32 * scale, cy - 30 * scale),
      Offset(cx + 36 * scale, cy - 36 * scale),
    );
  }

  @override
  bool shouldRepaint(_HandPainter old) => old.shape != shape || old.color != color;
}
