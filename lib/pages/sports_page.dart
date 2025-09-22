import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer_menu.dart';
import '../widgets/article_image.dart';
import 'article_detail_page.dart';
import 'home_page.dart';
import 'trends_page.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});

  void _goHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  void _onDrawerTap(BuildContext context, int i) {
    if (i == 0) {
      _goHome(context);
    } else if (i == 1) {
      Navigator.pop(context); // ya estás en Deportes
    } else if (i == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TrendsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.inter(
      color: const Color(0xFF1565C0),
      fontSize: 22,
      fontWeight: FontWeight.w800,
      height: 1.15,
    );
    final subtitleStyle = GoogleFonts.inter(
      fontSize: 14,
      color: Colors.black87,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
            tooltip: 'Menú',
          ),
        ),
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.search, color: Colors.black54),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: .7, color: Color(0x11000000)),
        ),
      ),

      drawer: DrawerMenu(
        selectedIndex: 1,
        onMenuItemTapped: (i) => _onDrawerTap(context, i),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: const [
          _SportsCard(
            image: 'assets/images/alexis.jpg',
            title:
                'Qué dijo Alexis Sánchez tras la victoria y la reflexión del técnico',
            subtitle: 'El delantero chileno analizó el partido…',
          ),
          _SportsCard(
            image: 'assets/images/tabilo.jpg',
            title: 'Tabilo avanza con sólida presentación en el torneo ATP',
            subtitle: 'El chileno se mete en la siguiente ronda.',
          ),
          _SportsCard(
            image: 'assets/images/copa-libertadores.jpg',
            title: 'Copa Libertadores: así quedaron las llaves de semifinales',
            subtitle: 'Cruces de alto voltaje en Sudamérica.',
          ),
          _SportsCard(
            image: 'assets/images/champions.jpg',
            title: 'Champions League: resultados de la jornada',
            subtitle: 'Goles, sorpresas y tabla de posiciones.',
          ),
        ],
      ),
    );
  }
}

class _SportsCard extends StatelessWidget {
  const _SportsCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.inter(
      color: const Color(0xFF1565C0),
      fontSize: 22,
      fontWeight: FontWeight.w800,
      height: 1.15,
    );
    final subtitleStyle = GoogleFonts.inter(
      fontSize: 14,
      color: Colors.black87,
    );

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleDetailPage(
                title: title,
                imageUrl:
                    image, // 👈 usar imageUrl (coincide con ArticleDetailPage)
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleImage(
                imageUrl: image,
              ), // 👈 usar imageUrl (coincide con ArticleImage)
              const SizedBox(height: 12),
              Text(title, style: titleStyle),
              const SizedBox(height: 8),
              Text(subtitle, style: subtitleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
