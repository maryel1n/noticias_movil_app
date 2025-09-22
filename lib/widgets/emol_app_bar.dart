// Funcionalidad adicional #4:
// Acceso rápido al Home al tocar el logo, replicando el comportamiento del sitio.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmolAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmolAppBar({
    super.key,
    required this.onLogoTap,
    this.showMenuButton = true,
  });

  final VoidCallback onLogoTap;
  final bool showMenuButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showMenuButton
          ? Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black87),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                tooltip: 'Menú',
              ),
            )
          : null,
      title: GestureDetector(
        onTap: onLogoTap,
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
    );
  }
}
