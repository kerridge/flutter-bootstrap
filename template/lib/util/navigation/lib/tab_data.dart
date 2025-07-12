import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class TabData {
  const TabData();

  int get index;

  String get name;

  String get path;

  IconData get icon;

  String get label;

  StatefulShellBranch get branch;
}
