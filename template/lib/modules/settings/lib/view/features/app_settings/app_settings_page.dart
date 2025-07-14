import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/ui_library/ui_library.api.dart';
import 'package:template/util/module/module.dart';

class AppSettingsPage extends HookConsumerWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref
        .read(ModuleRegistry.provider)
        .settings
        .values
        .expand((m) => m)
        .toList();

    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 3,
            child: SideMenu(
              items: settings
                  .map(
                    (s) => SideMenuDataItem(
                      title: s.title,
                      icon: s.icon,
                      route: s.route,
                    ),
                  )
                  .toList(),
            ),
          ),
          Flexible(flex: 7, child: Column(children: [Text('App Settings')])),
        ],
      ),
    );
  }
}
