import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/modules/home/home.api.dart';
import 'package:template/ui_library/ui_library.api.dart';

class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signup'),
          UITextButton(
            label: 'Signup',
            onPressed: () {
              HomeRoutes.home.replace(context);
            },
          ),
        ],
      ),
    );
  }
}
