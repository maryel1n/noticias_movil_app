import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  /// 0 = Home, 1 = Deportes, 2 = Tendencias (puedes extenderlo)
  final int selectedIndex;
  final void Function(int) onMenuItemTapped;

  const DrawerMenu({
    super.key,
    required this.selectedIndex,
    required this.onMenuItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header simple (sin assets para no fallar)
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.red),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'emol.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          _item(0, Icons.article, 'Portada'),
          _item(1, Icons.sports_soccer, 'Deportes'),
          _item(2, Icons.trending_up, 'Tendencias'),
        ],
      ),
    );
  }

  Widget _item(int index, IconData icon, String title) {
    final selected = selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: selected ? Colors.red : Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      onTap: () => onMenuItemTapped(index),
    );
  }
}
