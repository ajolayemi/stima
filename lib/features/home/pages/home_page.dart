import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome to the Home Page!'),
            // SizedBox(height: 16),
            // AppPrimaryButton(
            //   label: 'logout',
            //   onPressed: () {
            //     ref.read(loginControllerProvider.notifier).logout();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
