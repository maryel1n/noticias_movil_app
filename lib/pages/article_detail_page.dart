import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.summary,
    required this.time,
    required this.comments,
  });

  final String title, imageUrl, summary, time;
  final int comments;

  static const emolBlue = Color(0xFF1E5BB8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noticia')),
      body: ListView(
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: emolBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 18,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(time),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 18,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(width: 4),
                    Text('$comments'),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  // texto de relleno replicando la bajada
                  ('$summary\n\n') * 6,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
