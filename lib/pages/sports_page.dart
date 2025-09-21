import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer_menu.dart';
import 'home_page.dart';
import 'trends_page.dart';
import 'article_detail_page.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});

  static const emolBlue = Color(0xFF1E5BB8);
  static const emolGreen = Color(0xFF2FAA26);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      drawer: DrawerMenu(
        selectedIndex: 1, // 0=Home, 1=Deportes, 2=Tendencias
        onMenuItemTapped: (index) {
          Navigator.pop(context);
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
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
            const _SectionHeader(),
            const _ScoreBox(),
            const SizedBox(height: 8),
            _NewsCard(article: _sArticles[0], featured: true),
            _NewsCard(article: _sArticles[1]),
            const _PromoRow(),
            _NewsCard(article: _sArticles[2]),
            const _PromoRow2(),
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
            'Deportes',
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Container(height: 3, color: SportsPage.emolGreen),
        ],
      ),
    );
  }
}

class _ScoreBox extends StatelessWidget {
  const _ScoreBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE6E9ED)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _TopBar.emolBlue,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(6),
              ),
            ),
            width: double.infinity,
            child: Text(
              'PROGRAMACIÓN Y RESULTADOS',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: .3,
              ),
            ),
          ),
          Container(
            color: const Color(0xFFEBEEF2),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                'FECHA 1 - CHAMPIONS LEAGUE',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const _MatchRow(left: _Match('FRK', 5, 'GAL', 1)),
          const _MatchRow(left: _Match('SPO', 4, 'KAI', 1)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Match {
  final String home;
  final int homeScore;
  final String away;
  final int awayScore;
  const _Match(this.home, this.homeScore, this.away, this.awayScore);
}

class _MatchRow extends StatelessWidget {
  final _Match left;
  const _MatchRow({required this.left});

  @override
  Widget build(BuildContext context) {
    Widget badge(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD8DEE5)),
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );

    Widget score(int n) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FA),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$n',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
      ),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  badge(left.home),
                  const SizedBox(width: 8),
                  score(left.homeScore),
                ],
              ),
              Row(
                children: [
                  badge(left.away),
                  const SizedBox(width: 8),
                  score(left.awayScore),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Text(
            'FIN',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class _NewsCard extends StatelessWidget {
  final _SArticle article;
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
            if (article.summary.isNotEmpty)
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

class _PromoRow extends StatelessWidget {
  const _PromoRow();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            height: 90,
            child: Image.network(
              'https://picsum.photos/seed/golagol/600/400',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Resultados de los cuartos de final de la Copa Libertadores',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E5BB8),
                    ),
                  ),
                  SizedBox(height: 6),
                  _MetaRow(time: '23:25', comments: 54),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoRow2 extends StatelessWidget {
  const _PromoRow2();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            height: 90,
            child: Image.network(
              'https://picsum.photos/seed/champions/600/400',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Resultados de la primera fecha de la Champions League',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E5BB8),
                    ),
                  ),
                  SizedBox(height: 6),
                  _MetaRow(time: '17:59', comments: 73),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String time;
  final int comments;
  const _MetaRow({required this.time, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.access_time, size: 18, color: Colors.blueGrey),
        const SizedBox(width: 4),
        Text(time),
        const SizedBox(width: 12),
        const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.blueGrey),
        const SizedBox(width: 4),
        Text('$comments'),
      ],
    );
  }
}

class _SArticle {
  final String title, summary, imageUrl, time;
  final int comments;
  const _SArticle({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.time,
    required this.comments,
  });
}

const _sArticles = <_SArticle>[
  _SArticle(
    title:
        'Tremenda definición casi en la línea: Botsuana venció a EE.UU. y se quedó con el oro 4x400',
    summary:
        'El equipo africano superó al estadounidense en el cierre de una final para el recuerdo.',
    imageUrl: 'https://picsum.photos/seed/deportes1/1200/700',
    time: '15:00',
    comments: 9,
  ),
  _SArticle(
    title:
        'Revelan el secreto del gol de Alexis Sánchez para el Sevilla y el festejo con Gabriel Suazo',
    summary:
        'El ex Arsenal se llevó los aplausos tras su actuación frente al Alavés.',
    imageUrl: 'https://picsum.photos/seed/deportes2/1200/700',
    time: '23:25',
    comments: 54,
  ),
  _SArticle(
    title:
        'Las sentidas palabras de Tabilo tras su triunfo en Chengdú y cómo se juegan las semis',
    summary: 'El zurdo sigue ganando en China.',
    imageUrl: 'https://picsum.photos/seed/deportes3/1200/700',
    time: '13:23',
    comments: 9,
  ),
];
