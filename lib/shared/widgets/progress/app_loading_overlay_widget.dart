import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/shared/widgets/progress/app_loading_widget.dart';

class AppLoadingOverlayWidget extends StatelessWidget {
  const AppLoadingOverlayWidget({
    super.key,
    required this.child,
    this.showLoadingText = true,
    this.addScaffold = false,
    this.isLoading = false,
  });

  final Widget child;
  final bool showLoadingText;
  final bool addScaffold;
  final bool isLoading;

  Widget _content() {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(color: AppColors.gray100, dismissible: false),
          ),
          AppLoadingWidget(showText: showLoadingText)
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return addScaffold ? Scaffold(body: _content()) : _content();
  }
}
