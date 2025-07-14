import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'side_menu_data_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.items});

  final List<SideMenuDataItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 21, 21, 21),
      child: Column(
        children: [
          ...items.map(
            (item) => ListTile(
              title: Text(item.title),
              leading: Icon(item.icon),
              onTap: () => context.replace(item.route),
            ),
          ),
        ],
      ),
    );
  }
}
