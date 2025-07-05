import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:template/util/navigator/lib/screen_spec/screen_spec.api.dart';

import '../todos_page.dart';

class TodosScreenSpec extends ScreenSpec {
  const TodosScreenSpec();

  @override
  void encode(UrlParams params) {}

  factory TodosScreenSpec.decode(UrlParams params) {
    return const TodosScreenSpec();
  }

  @override
  List<ScreenPresentationMode> get presentationModes => [
    ScreenPresentationMode.push,
  ];

  @override
  String get title => 'Todos';
}

final todosScreenRoute = MyRoute(
  pathSegment: 'todos',
  decode: TodosScreenSpec.decode,
  builder: TodosPage.new,
);
