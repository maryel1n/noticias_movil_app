import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer_menu.dart';
import 'sports_page.dart';
import 'trends_page.dart';
import 'article_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const emolBlue = Color(0xFF1E5BB8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      drawer: DrawerMenu(
        selectedIndex: 0, // 0=Home, 1=Deportes, 2=Tendencias
        onMenuItemTapped: (index) {
          Navigator.pop(context);
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SportsPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TrendsPage()),
            );
          }
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const _TopBar(),
            const _BreakingBanner(),
            const SizedBox(height: 12),
            _NewsCard(article: _demoArticles[0], featured: true),
            for (final a in _demoArticles.skip(1)) _NewsCard(article: a),
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
          Container(
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.water_drop, size: 16, color: emolBlue),
                SizedBox(width: 6),
                Text('13°C', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const Spacer(),
          Text(
            'emol.',
            style: GoogleFonts.inter(
              color: emolBlue,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
    );
  }
}

class _BreakingBanner extends StatelessWidget {
  const _BreakingBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE6E9ED)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  color: const Color(0xFF20262E),
                  fontSize: 14,
                  height: 1.3,
                ),
                children: const [
                  TextSpan(
                    text: 'EMOLTV  ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Streaming y entrevistas: La programación para este fin de semana',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.close, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final _Article article;
  final bool featured;
  const _NewsCard({required this.article, this.featured = false});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: featured ? 22 : 18,
      height: 1.2,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF1E5BB8),
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
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        clipBehavior: Clip.antiAlias,
        elevation: featured ? 2 : 1,
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 18,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 4),
                  Text(article.time),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 4),
                  Text('${article.comments}'),
                ],
              ),
            ),
            if (featured && article.summary.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Text(
                  article.summary,
                  style: const TextStyle(height: 1.3),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Datos mock
class _Article {
  final String title, summary, imageUrl, time;
  final int comments;
  const _Article({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.time,
    required this.comments,
  });
}

const _demoArticles = <_Article>[
  _Article(
    title:
        '"Turbazos": Los casos que despertaron la preocupación del Gobierno y el llamado de diputados a tomar medidas',
    summary:
        'El ministro de Seguridad Pública reconoció inquietud tras un asalto reciente...',
    imageUrl: 'https://picsum.photos/seed/home1/1200/700',
    time: '21:32',
    comments: 79,
  ),
  _Article(
    title:
        'Tornado en Linares: Senapred cifra 83 viviendas con daños y 850 clientes sin luz',
    summary: 'En el Biobío se registró una tromba marina; hubo anegamientos.',
    imageUrl: 'https://picsum.photos/seed/home2/1200/700',
    time: '22:18',
    comments: 1,
  ),
  _Article(
    title:
        'Qué dijo Alexis Sánchez tras la victoria y la reflexión del técnico',
    summary: 'El delantero chileno fue figura y dejó declaraciones.',
    imageUrl: 'https://picsum.photos/seed/home3/1200/700',
    time: '20:00',
    comments: 72,
  ),
];
