// Funcionalidad adicional #5:
// Botón para expandir el cuerpo de la noticia y bloque de "noticias relacionadas".
// Mejora la experiencia y la fidelidad con el sitio original.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/article_image.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.author,
    this.dateString,
    this.body,
    this.related,
  });

  final String title;
  final String imageUrl;
  final String? subtitle;
  final String? author;
  final String? dateString;
  final List<String>? body;
  final List<RelatedItem>? related;

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late List<String> _paragraphs;
  late List<RelatedItem> _related;
  bool _expanded = false;

  void _goHome(BuildContext context) {
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  void initState() {
    super.initState();

    _paragraphs =
        widget.body ??
        [
          'Esta es una versión resumida del contenido. Estamos replicando el estilo de EMOL para tu app con Flutter.',
          'La nota incluye antecedentes, contexto y declaraciones clave. Al pulsar "Leer artículo completo" verás el texto extendido.',
          'También añadimos un bloque de "Noticias relacionadas" para fomentar la navegación dentro de tu app.',
          'Esta es la sección expandida del artículo, visible solo cuando pulsas el botón.',
        ];

    _related =
        widget.related ??
        [
          RelatedItem(
            title:
                'Tornado en Linares: Senapred cifra 83 viviendas con daños y 850 clientes sin luz',
            imageUrl: 'assets/images/tornado-linares.jpg',
          ),
          RelatedItem(
            title:
                'Qué dijo Alexis Sánchez tras la victoria y la reflexión del técnico',
            imageUrl: 'assets/images/alexis.jpg',
          ),
          RelatedItem(
            title: 'Ideas de clósets modulares que están en tendencia',
            imageUrl: 'assets/images/closets.jpg',
          ),
        ];
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.inter(
      color: const Color(0xFF1565C0),
      fontSize: 26,
      fontWeight: FontWeight.w800,
      height: 1.15,
    );
    final subtitleStyle = GoogleFonts.inter(
      fontSize: 16,
      color: Colors.black87,
      height: 1.35,
    );
    final metaStyle = GoogleFonts.inter(fontSize: 12, color: Colors.black54);
    final relatedTitleStyle = GoogleFonts.inter(
      color: const Color(0xFF1565C0),
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.2,
    );

    final visibleParagraphs = _expanded ? _paragraphs : _paragraphs.take(2);

    return Scaffold(
      // AppBar con logo “emol.” que vuelve al Home al tocarlo
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
        title: GestureDetector(
          onTap: () => _goHome(context),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'emol',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF1565C0),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: '.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFE53935),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: .7, color: Color(0x11000000)),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          ArticleImage(imageUrl: widget.imageUrl, height: 240),
          const SizedBox(height: 12),
          Text(widget.title, style: titleStyle),
          const SizedBox(height: 6),
          if (widget.subtitle != null &&
              widget.subtitle!.trim().isNotEmpty) ...[
            Text(widget.subtitle!, style: subtitleStyle),
            const SizedBox(height: 6),
          ],
          if ((widget.dateString?.isNotEmpty ?? false) ||
              (widget.author?.isNotEmpty ?? false)) ...[
            Row(
              children: [
                if (widget.dateString != null && widget.dateString!.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 14,
                        color: Colors.black45,
                      ),
                      const SizedBox(width: 4),
                      Text(widget.dateString!, style: metaStyle),
                    ],
                  ),
                if ((widget.dateString?.isNotEmpty ?? false) &&
                    (widget.author?.isNotEmpty ?? false))
                  const SizedBox(width: 12),
                if (widget.author != null && widget.author!.isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.person, size: 14, color: Colors.black45),
                      const SizedBox(width: 4),
                      Text(widget.author!, style: metaStyle),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          ...visibleParagraphs
              .map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    p,
                    style: GoogleFonts.inter(fontSize: 16, height: 1.45),
                  ),
                ),
              )
              .toList(),
          if (!_expanded && _paragraphs.length > 2)
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () => setState(() => _expanded = true),
                icon: const Icon(Icons.article),
                label: const Text('Leer artículo completo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Noticias relacionadas',
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          ..._related.map(
            (r) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailPage(
                        title: r.title,
                        imageUrl: r.imageUrl,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 110,
                          height: 72,
                          child: ArticleImage(
                            imageUrl: r.imageUrl,
                            height: 72,
                            radius: 12,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          r.title,
                          style: relatedTitleStyle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RelatedItem {
  final String title;
  final String imageUrl;

  const RelatedItem({required this.title, required this.imageUrl});
}
