import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:template/util/navigation/navigation.api.dart';

import 'tab.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    required this.onTabTap,
  });

  final List<TabData> tabs;
  final int currentIndex;
  final ValueChanged<int> onTabTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: tabs.mapIndexed((index, tab) {
              return Expanded(
                child: AppBottomNavigationBarTab(
                  tab: tab,
                  isSelected: index == currentIndex,
                  onTap: () => onTabTap(index),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
