import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenuDataItem {
  final String title;
  final IconData? icon;
  final String route;

  const SideMenuDataItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}
