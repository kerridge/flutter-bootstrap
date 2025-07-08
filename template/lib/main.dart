import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/util/module/module.dart';

import 'package:template/util/navigator/lib/module/internal.di.dart';
import 'package:template/util/navigator/lib/routers/router.dart';

Future<void> main() async {
  final container = ProviderContainer(observers: [], overrides: []);

  final moduleRegistry = container.read(ModuleRegistry.provider);

  moduleRegistry.register(TodoModule());

  await moduleRegistry.initialize();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return RouterWidget(
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
