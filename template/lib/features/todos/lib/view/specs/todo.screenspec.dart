import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:template/util/navigator/lib/screen_spec/screen_spec.api.dart';

import '../todo_page.dart';

class TodoScreenSpec extends ScreenSpec {
  const TodoScreenSpec({required this.id});

  final String id;

  @override
  void encode(UrlParams params) {
    params.setString('id', id);
  }

  factory TodoScreenSpec.decode(UrlParams params) {
    return TodoScreenSpec(id: params.getString('id'));
  }

  @override
  List<ScreenPresentationMode> get presentationModes => [
    ScreenPresentationMode.push,
  ];

  @override
  String get title => 'Todo [$id]';
}

final todoScreenRoute = MyRoute(
  pathSegment: 'todo',
  decode: TodoScreenSpec.decode,
  builder: TodoPage.new,
);
