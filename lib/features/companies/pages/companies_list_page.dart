import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';

class CompaniesListPage extends ConsumerWidget {
  const CompaniesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      body: ResponsiveScrollable(
        child: PaddedSafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text('Companies List Page')],
          ),
        ),
      ),
    );
  }
}
