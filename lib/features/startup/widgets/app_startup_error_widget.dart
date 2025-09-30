import 'package:flutter/material.dart';

// TODO: [Kehinde] - finish implementation
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Si è verificato un errore durante l\'avvio dell\'app'),
            // ErrorMessageWidget(message),
            // CTAButton(
            //   text: 'Riprova',
            //   buttonType: ButtonType.primary,
            //   onPressed: onRetry,
            // ),
          ],
        ),
      ),
    );
  }
}
