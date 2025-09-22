import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer_menu.dart';
import '../widgets/article_image.dart';
import 'article_detail_page.dart';
import 'home_page.dart';
import 'sports_page.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage({super.key});

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SportsPage()),
      );
    } else if (i == 2) {
      Navigator.pop(context); // ya estás en Tendencias
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
        selectedIndex: 2,
        onMenuItemTapped: (i) => _onDrawerTap(context, i),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const _SectionHeader(text: 'TENDENCIAS'),
          const SizedBox(height: 8),

          // Cards
          const _TrendsCard(
            image: 'assets/images/carlos.jpg',
            title: 'Video | Carlos III visita a la mujer más longeva del mundo',
            subtitle: 'La británica cumplió 116 años en agosto…',
          ),
          const _TrendsCard(
            image: 'assets/images/closets.jpg',
            title: 'Ideas de clósets modulares que están en tendencia',
            subtitle: 'Almacenamiento inteligente y estiloso.',
          ),
          const _TrendsCard(
            image: 'assets/images/chileno.jpg',
            title: 'Chileno crea app que revoluciona la organización del hogar',
            subtitle: 'Tecnología y vida diaria.',
          ),
          const _TrendsCard(
            image: 'assets/images/india.jpg',
            title: 'India: nuevo récord en energías renovables',
            subtitle: 'Crecimiento sostenido del sector.',
          ),
        ],
      ),
    );
  }
}

class _TrendsCard extends StatelessWidget {
  const _TrendsCard({
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
              builder: (_) => ArticleDetailPage(title: title, imageUrl: image),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleImage(imageUrl: image),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final labelStyle = GoogleFonts.inter(
      color: const Color(0xFFE53935),
      fontSize: 16,
      fontWeight: FontWeight.w800,
      letterSpacing: .6,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 6),
      child: Row(
        children: [
          Text(text, style: labelStyle),
          const SizedBox(width: 8),
          const Expanded(
            child: Divider(thickness: 2, color: Color(0xFFE53935)),
          ),
        ],
      ),
    );
  }
}
