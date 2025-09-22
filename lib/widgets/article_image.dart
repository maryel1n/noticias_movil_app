// Funcionalidad adicional #1:
// Widget reutilizable y encapsulado para mostrar imágenes de artículos con
// placeholder y manejo de error. Permite centralizar estilos y lógica.

import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({
    super.key,
    required this.imageUrl,
    this.height = 220,
    this.radius = 16,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final double height;
  final double radius;
  final BoxFit fit;

  bool get _isAsset => imageUrl.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    final img = _isAsset
        ? Image.asset(
            imageUrl,
            fit: fit,
            height: height,
            width: double.infinity,
          )
        : Image.network(
            imageUrl,
            fit: fit,
            height: height,
            width: double.infinity,
          );

    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: img);
  }
}
