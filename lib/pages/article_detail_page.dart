import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetailPage extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String summary;
  final String time;
  final int comments;
  final String author;

  const ArticleDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.time,
    required this.comments,
    this.author = 'Redacción Emol',
  });

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  static const emolBlue = Color(0xFF1E5BB8);

  final _scrollCtrl = ScrollController();
  final _expandedAnchor = GlobalKey();
  bool _expanded = false;

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'emol.',
          style: GoogleFonts.inter(
            color: emolBlue,
            fontWeight: FontWeight.w800,
            fontSize: 22,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE74C3C),
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Compartir (demo)'))),
        child: const Icon(Icons.share, color: Colors.white, size: 26),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollCtrl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _headline(),
              _heroImage(widget.imageUrl),
              _caption(
                'El presidente Gabriel Boric viajará este lunes 22 de septiembre a Nueva York, Estados Unidos.',
              ),
              const Divider(height: 1),

              // Título y metadatos
              _titleBlock(widget.title),
              _metaRow(
                time: widget.time,
                author: widget.author,
                comments: widget.comments,
              ),

              // Párrafos iniciales (previo a expandir)
              _paragraph(widget.summary),
              _paragraph(
                'Diversas son las expectativas que tienen parlamentarios respecto del viaje que realizará el presidente Gabriel Boric a la ONU, en Nueva York, Estados Unidos.',
              ),
              _paragraph(
                'El Mandatario participará en distintas actividades, siendo parte de la apertura y debate de la 80ª Asamblea General de Naciones Unidas.',
              ),

              // Botón para desplegar contenido completo
              if (!_expanded)
                _primaryButton(
                  label: 'Leer artículo completo',
                  onTap: () async {
                    setState(() => _expanded = true);
                    await Future.delayed(const Duration(milliseconds: 100));
                    final ctx = _expandedAnchor.currentContext;
                    if (ctx != null) {
                      Scrollable.ensureVisible(
                        ctx,
                        duration: const Duration(milliseconds: 350),
                        alignment: 0.05,
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),

              // Sección expandida (anclada)
              if (_expanded) ...[
                Container(key: _expandedAnchor),
                _subTitle('Contexto y reacciones'),
                _paragraph(
                  'Desde la Comisión de Relaciones Exteriores se valoró la oportunidad para reafirmar principios como el multilateralismo, el respeto a los DD.HH. y la resolución pacífica de controversias.',
                ),
                _quote(
                  '“Será una instancia clave para posicionar los intereses del país y fortalecer alianzas estratégicas”.',
                ),
                _paragraph(
                  'En el itinerario se contemplan reuniones bilaterales, encuentros con la comunidad chilena y actividades de promoción económica.',
                ),
                _bulletPoints(const [
                  'Apertura de la Asamblea General',
                  'Reuniones bilaterales con jefes de Estado',
                  'Encuentro con la comunidad chilena en Nueva York',
                  'Agenda económica y de inversiones',
                ]),
                const SizedBox(height: 12),

                // Noticias relacionadas
                _relatedTitle(),
                _relatedGrid(),

                const SizedBox(height: 12),
                _commentsPlaceholder(),
                const SizedBox(height: 24),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ─────────── Widgets reutilizables ───────────

  Widget _headline() => Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            'EMOLTV  Streaming y entrevistas: La programación para este fin de semana',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF20262E),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.close, size: 18, color: Colors.grey),
      ],
    ),
  );

  Widget _heroImage(String url) => AspectRatio(
    aspectRatio: 16 / 9,
    child: Image.network(url, fit: BoxFit.cover),
  );

  Widget _caption(String text) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
    child: Text(text, style: GoogleFonts.inter(fontSize: 14, height: 1.25)),
  );

  Widget _titleBlock(String t) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 16, 12, 10),
    child: Text(
      t,
      style: GoogleFonts.inter(
        color: emolBlue,
        fontWeight: FontWeight.w800,
        height: 1.15,
        fontSize: 26,
      ),
    ),
  );

  Widget _metaRow({
    required String time,
    required String author,
    required int comments,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
      child: Row(
        children: [
          Text(
            '21 de Septiembre de 2025 | $time | Por ',
            style: GoogleFonts.inter(),
          ),
          Text(
            author,
            style: GoogleFonts.inter(
              color: emolBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.chat_bubble_outline,
            size: 18,
            color: Colors.blueGrey,
          ),
          const SizedBox(width: 4),
          Text('$comments'),
        ],
      ),
    );
  }

  Widget _paragraph(String text) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
    child: Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16,
        height: 1.5,
        color: const Color(0xFF20262E),
      ),
    ),
  );

  Widget _subTitle(String text) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 16, 12, 6),
    child: Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: emolBlue,
      ),
    ),
  );

  Widget _quote(String text) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
    child: Row(
      children: [
        Container(width: 4, height: 60, color: const Color(0xFFB3C7E6)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontStyle: FontStyle.italic,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _bulletPoints(List<String> items) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: TextStyle(fontSize: 18)),
                  Expanded(
                    child: Text(e, style: GoogleFonts.inter(height: 1.4)),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    ),
  );

  Widget _primaryButton({
    required String label,
    required VoidCallback onTap,
  }) => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
    child: SizedBox(
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: emolBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    ),
  );

  Widget _relatedTitle() => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
    child: RichText(
      text: TextSpan(
        style: GoogleFonts.inter(
          color: const Color(0xFF2B2F36),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        children: const [
          TextSpan(
            text: 'NOTICIAS ',
            style: TextStyle(color: emolBlue),
          ),
          TextSpan(text: 'RELACIONADAS'),
        ],
      ),
    ),
  );

  Widget _relatedGrid() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 16),
      child: Row(
        children: [
          Expanded(child: _relatedCard(_related[0])),
          const SizedBox(width: 12),
          Expanded(child: _relatedCard(_related[1])),
        ],
      ),
    );
  }

  Widget _relatedCard(_Related a) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(a.imageUrl, fit: BoxFit.cover),
      ),
      const SizedBox(height: 6),
      Text(
        a.title,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(color: emolBlue, fontWeight: FontWeight.w700),
      ),
      const SizedBox(height: 6),
      Row(
        children: const [
          Icon(Icons.chat_bubble_outline, size: 18, color: Colors.blueGrey),
          SizedBox(width: 4),
          Text(''),
        ],
      ),
    ],
  );

  Widget _commentsPlaceholder() => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comenta esta noticia:',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          'Inicia sesión para interactuar y debatir sobre los temas noticiosos.',
          style: GoogleFonts.inter(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            OutlinedButton(onPressed: () {}, child: const Text('Ingresar')),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: () {}, child: const Text('Registrarse')),
          ],
        ),
      ],
    ),
  );
}

// ─────────── Datos mock de “relacionadas” ───────────

class _Related {
  final String title;
  final String imageUrl;
  const _Related(this.title, this.imageUrl);
}

const _related = <_Related>[
  _Related(
    'Del discurso en la Asamblea General a reuniones bilaterales: las actividades de Boric en su viaje a la ONU',
    'https://picsum.photos/seed/rel1/800/450',
  ),
  _Related(
    'Carrera a la ONU: cartas para levantar una candidatura a la secretaría general',
    'https://picsum.photos/seed/rel2/800/450',
  ),
];
