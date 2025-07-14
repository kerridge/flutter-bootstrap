import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/modules/auth/lib/module/auth.module.dart';
import 'package:template/modules/home/lib/module/home.module.dart';
import 'package:template/modules/todos/lib/module/todo.module.dart';
import 'package:template/modules/settings/lib/module/settings.module.dart';
import 'package:template/util/module/module.dart';

Future<ProviderContainer> preinit() async {
  final container = ProviderContainer(observers: [], overrides: []);

  // Use path over hash routing for web
  usePathUrlStrategy();

  // Whether the imperative API affects browser URL bar.
  GoRouter.optionURLReflectsImperativeAPIs = true;

  final moduleRegistry = container.read(ModuleRegistry.provider);

  moduleRegistry.registerRootModule(AuthModule());

  moduleRegistry
    ..register(SettingsModule())
    ..register(HomeModule())
    ..register(TodoModule());

  await moduleRegistry.initialize();

  return container;
}
