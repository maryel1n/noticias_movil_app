// Funcionalidad adicional #2:
// Estrategia de imágenes: intenta asignar imágenes coherentes por título/sección
// y provee un fallback estable. Mejora fidelidad visual sin depender de backend.

import 'package:flutter/material.dart';
import '../data/manual_images.dart';

class ImageHelper {
  static String _norm(String s) {
    final lower = s.toLowerCase();
    const repl = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'ü': 'u',
      'ñ': 'n',
    };
    final b = StringBuffer();
    for (final ch in lower.runes) {
      final c = String.fromCharCode(ch);
      b.write(repl[c] ?? c);
    }
    return b.toString();
  }

  static String? assetForTitle(String title) {
    final t = _norm(title);
    for (final e in manualImages.entries) {
      if (t.contains(_norm(e.key))) return e.value;
    }
    return null;
  }

  static String _seedFrom(String title, {String? section}) {
    final base = ('${section ?? ''} $title').toLowerCase();
    final clean = base.replaceAll(RegExp(r'[^a-z0-9]+'), '-');
    return clean.isEmpty
        ? 'news'
        : clean.substring(0, clean.length.clamp(1, 40));
  }

  static String imageFromTitle(
    String title, {
    String? section,
    int w = 1200,
    int h = 700,
  }) {
    final seed = _seedFrom(title, section: section);
    return 'https://picsum.photos/seed/$seed/$w/$h.jpg';
  }

  /// Compatibilidad si alguna parte del código aún espera una URL.
  static String unsplashFromTitle(
    String title, {
    String? section,
    int w = 1200,
    int h = 700,
  }) => imageFromTitle(title, section: section, w: w, h: h);

  static Widget widgetFromTitle(
    String title, {
    String? section,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    String? semanticsLabel,
  }) {
    final asset = assetForTitle(title);

    final Widget img = asset != null
        ? Image.asset(
            asset,
            width: width,
            height: height,
            fit: fit,
            semanticLabel: semanticsLabel,
          )
        : Image.network(
            imageFromTitle(title, section: section),
            width: width,
            height: height,
            fit: fit,
            semanticLabel: semanticsLabel,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported),
            ),
          );

    return borderRadius != null
        ? ClipRRect(borderRadius: borderRadius, child: img)
        : img;
  }
}
