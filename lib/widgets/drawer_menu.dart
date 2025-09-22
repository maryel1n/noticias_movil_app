import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.selectedIndex,
    required this.onMenuItemTapped,
  });

  final int selectedIndex;
  final void Function(int index) onMenuItemTapped;

  @override
  Widget build(BuildContext context) {
    Widget item(int i, IconData icon, String text) {
      final selected = i == selectedIndex;
      return ListTile(
        leading: Icon(icon, color: selected ? Colors.red : Colors.grey[700]),
        title: Text(
          text,
          style: TextStyle(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: selected,
        onTap: () {
          Navigator.pop(context);
          if (!selected) onMenuItemTapped(i);
        },
      );
    }

    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 8),
            item(0, Icons.article, 'Portada'),
            item(1, Icons.sports_soccer, 'Deportes'),
            item(2, Icons.trending_up, 'Tendencias'),
          ],
        ),
      ),
    );
  }
}
