import 'package:flutter/material.dart';

/// Representasi item dalam menu popup
class OpsiItem {
  final String value;
  final String label;
  const OpsiItem({required this.value, required this.label});
}

/// Widget popup dengan opsi yang dikelompokkan
class OpsiPopup extends StatelessWidget {
  /// Grup item yang ditampilkan (setiap grup bisa dipisahkan dengan Divider)
  final List<List<OpsiItem>> items;

  /// Fungsi yang dijalankan saat opsi dipilih
  final void Function(String value) onSelected;

  const OpsiPopup({super.key, required this.items, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz, color: Colors.black),
      onSelected: onSelected,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: const BorderSide(
          color: Color.fromARGB(255, 235, 238, 242),
          width: 1,
        ),
      ),
      itemBuilder: (context) {
        if (items.isEmpty) return [];

        final List<PopupMenuEntry<String>> menu = [];

        for (int i = 0; i < items.length; i++) {
          final group = items[i];

          for (int j = 0; j < group.length; j++) {
            final item = group[j];

            menu.add(
              PopupMenuItem<String>(
                value: item.value,
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );

            // Tambahkan garis pemisah antar item di dalam grup
            if (j < group.length - 1) {
              menu.add(const PopupMenuDivider(height: 1));
            }
          }

          // Tambahkan garis pemisah antar grup
          if (i < items.length - 1) {
            menu.add(const PopupMenuDivider(height: 12));
          }
        }

        return menu;
      },
    );
  }
}
