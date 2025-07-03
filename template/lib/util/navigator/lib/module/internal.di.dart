import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/util/navigator/lib/routers/go_router/go_router.dart';

final goRouterProvider = NotifierProvider<AppGoRouter, GoRouter>(
  AppGoRouter.new,
);
