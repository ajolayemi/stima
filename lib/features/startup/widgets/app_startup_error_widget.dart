import 'package:flutter/material.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_center_widget.dart';

// TODO: complete implementation
/// Widget to show if app initialization fails
class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasAppBar: false,
      body: ResponsiveCenter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Si è verificato un errore durante l\'avvio dell\'app'),
            // ErrorMessageWidget(message),
            // AppPrimaryButton(label: 'Riprova', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
