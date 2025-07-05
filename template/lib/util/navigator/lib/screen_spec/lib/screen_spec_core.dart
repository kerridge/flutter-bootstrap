import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/util/navigator/navigator.api.dart';

typedef UrlParams = Map<String, String>;

typedef FromUrlPars<T extends ScreenSpec> = T Function(UrlParams params);

typedef TypedPath = List<ScreenSpec>;

abstract class ScreenSpec {
  const ScreenSpec();

  void encode(UrlParams params);

  List<ScreenPresentationMode> get presentationModes;

  String get title;
}

typedef ScreenBuilder<T extends ScreenSpec> = Widget Function(T);

enum ScreenPresentationMode { push, drawer, dialog, bottomSheet }

class MyRoute<T extends ScreenSpec> {
  const MyRoute({
    required this.pathSegment,
    required this.decode,
    required this.builder,
  });

  final String pathSegment;

  final FromUrlPars<T> decode;

  final ScreenBuilder<T> builder;

  String segment2String(T segment) {
    final map = <String, String>{};
    segment.encode(map);
    final props =
        [pathSegment] +
        map.entries
            .map((kv) => '${kv.key}=${Uri.encodeComponent(kv.value)}')
            .toList();
    return props.join(';');
  }
}
