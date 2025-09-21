import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer_menu.dart';
import 'home_page.dart';
import 'sports_page.dart';
import 'article_detail_page.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage({super.key});

  static const emolBlue = Color(0xFF1E5BB8);
  static const trendsPurple = Color(0xFF8E44AD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      drawer: DrawerMenu(
        selectedIndex: 2, // 0=Home, 1=Deportes, 2=Tendencias
        onMenuItemTapped: (index) {
          Navigator.pop(context);
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SportsPage()),
            );
          }
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const _TopBar(),
            const _SectionHeader(),
            _NewsCard(article: _tArticles[0], featured: true),
            for (final a in _tArticles.skip(1)) _NewsCard(article: a),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  static const emolBlue = Color(0xFF1E5BB8);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          const Spacer(),
          // ← logo que siempre lleva a Home
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false,
              );
            },
            child: Text(
              'emol.',
              style: GoogleFonts.inter(
                color: emolBlue,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Spacer(),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tendencias',
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Container(height: 3, color: TrendsPage.trendsPurple),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final _TArticle article;
  final bool featured;
  const _NewsCard({required this.article, this.featured = false});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: featured ? 22 : 18,
      height: 1.2,
      fontWeight: FontWeight.w800,
      color: TrendsPage.emolBlue,
    );

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailPage(
              title: article.title,
              imageUrl: article.imageUrl,
              summary: article.summary,
              time: article.time,
              comments: article.comments,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(article.imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              child: Text(article.title, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 18,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(width: 4),
                      Text('${article.comments}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (article.summary.isNotEmpty)
                    Text(article.summary, style: const TextStyle(height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TArticle {
  final String title, summary, imageUrl, time;
  final int comments;
  const _TArticle({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.time,
    required this.comments,
  });
}

const _tArticles = <_TArticle>[
  _TArticle(
    title:
        'Video | Carlos III visita a Ethel Caterham, la mujer más longeva del mundo: lanzó al rey un atrevido comentario',
    summary:
        'La británica cumplió 116 años en agosto y dijo que haría una excepción para recibir al rey.',
    imageUrl: 'https://picsum.photos/seed/trend1/1200/700',
    time: '12:30',
    comments: 36,
  ),
  _TArticle(
    title:
        'Clósets compartidos: la tendencia joven para intercambiar prendas y crear un stock infinito sin invertir',
    summary:
        'Algunos lo hacen por sostenibilidad, aunque no sea su principal motivación.',
    imageUrl: 'https://picsum.photos/seed/trend2/1200/700',
    time: '13:05',
    comments: 27,
  ),
  _TArticle(
    title:
        'Pollo relleno, helado y whisky de 50.000 euros: el menú del banquete de Estado de Windsor',
    summary:
        'A la cena fue invitado Donald Trump por el rey Carlos III de Inglaterra.',
    imageUrl: 'https://picsum.photos/seed/trend3/1200/700',
    time: '14:07',
    comments: 140,
  ),
  _TArticle(
    title:
        'Fotos | Chileno gana premio mayor en concurso de aves con imagen de un martín pescador',
    summary:
        'Otras categorías del certamen también fueron conquistadas por chilenos.',
    imageUrl: 'https://picsum.photos/seed/trend4/1200/700',
    time: '10:39',
    comments: 46,
  ),
  _TArticle(
    title:
        'Entra por la nariz y causa la muerte en días: India declara alerta sanitaria por infecciones',
    summary:
        'Autoridades refuerzan medidas preventivas y llaman a consultar ante síntomas.',
    imageUrl: 'https://picsum.photos/seed/trend5/1200/700',
    time: '11:20',
    comments: 58,
  ),
];
