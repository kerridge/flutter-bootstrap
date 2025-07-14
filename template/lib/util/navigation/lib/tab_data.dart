import 'package:flutter/material.dart';

abstract class TabData {
  const TabData();

  int get order;

  String get name;

  String get path;

  IconData get icon;

  String get label;
}
