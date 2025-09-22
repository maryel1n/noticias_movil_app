import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer_menu.dart';
import '../widgets/article_image.dart';
import 'article_detail_page.dart';
import 'sports_page.dart';
import 'trends_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goHome(BuildContext context) {
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  void _onDrawerTap(BuildContext context, int i) {
    if (i == 0) {
      Navigator.pop(context); // ya estás en Portada
      return;
    }
    if (i == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SportsPage()),
      );
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
        selectedIndex: 0,
        onMenuItemTapped: (i) => _onDrawerTap(context, i),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _CardNoticia(
            image: 'assets/images/turbazo.jpg',
            title:
                '"Turbazos": Los casos que despertaron la preocupación del Gobierno y el llamado de diputados a tomar medidas',
            subtitle:
                'El ministro de Seguridad Pública reconoció inquietud tras un asalto reciente…',
            titleStyle: titleStyle,
            subtitleStyle: subtitleStyle,
          ),
          _CardNoticia(
            image: 'assets/images/tornado-linares.jpg',
            title:
                'Tornado en Linares: Senapred cifra 83 viviendas con daños y 850 clientes sin luz',
            subtitle:
                'Balance actualizado de afectaciones en la región del Maule.',
            titleStyle: titleStyle,
            subtitleStyle: subtitleStyle,
          ),
          _CardNoticia(
            image: 'assets/images/alexis.jpg',
            title:
                'Qué dijo Alexis Sánchez tras la victoria y la reflexión del técnico',
            subtitle: 'El ex Arsenal se lució.',
            titleStyle: titleStyle,
            subtitleStyle: subtitleStyle,
          ),
        ],
      ),
    );
  }
}

class _CardNoticia extends StatelessWidget {
  const _CardNoticia({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.titleStyle,
    required this.subtitleStyle,
  });

  final String image;
  final String title;
  final String subtitle;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;

  @override
  Widget build(BuildContext context) {
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
                imageUrl: image, // 👈 ahora pasa imageUrl
              ),
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
