import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart' show AppSizes;

class AppBaseDrawerContainer extends StatelessWidget {
  const AppBaseDrawerContainer({
    super.key,
    required this.child,
    this.scrollPhysics,
    this.childPadding,
    this.addDragHandlerIcon = true,
    this.isLoading = false,
    this.bottomStickyWidget,
    this.headerWidget,
  });

  final Widget child;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsets? childPadding;
  final bool addDragHandlerIcon;

  /// Defaults to false
  final bool isLoading;

  final Widget? bottomStickyWidget;

  final Widget? headerWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopScope(
          canPop: !isLoading,
          child: SafeArea(
            child: Container(
              width: context.screenWidth,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(AppSizes.p16),
                  right: Radius.circular(AppSizes.p16),
                ),
              ),
              child: Column(
                crossAxisAlignment: .stretch,
                mainAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  if (addDragHandlerIcon) ...[
                    AppSizes.gapH8,
                    ExcludeSemantics(
                      child: Assets.icons.drawerBorder.svg(fit: .scaleDown),
                    ),
                    AppSizes.gapH20,
                  ],

                  headerWidget ?? const SizedBox.shrink(),

                  Flexible(
                    child: SingleChildScrollView(
                      physics: scrollPhysics,
                      padding: childPadding,
                      child: child,
                    ),
                  ),

                  bottomStickyWidget ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),

        if (isLoading)
          Positioned.fill(
            child: GestureDetector(
              onVerticalDragStart: (_) {},
              onTap: () {},
              behavior: .opaque,
            ),
          ),
      ],
    );
  }
}
