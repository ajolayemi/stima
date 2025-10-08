import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      // appBar: AppBar(title: const Text('Home Page')),
      hasAppBar: true,
      canPop: AppUtils.pageCanPop(context),
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
