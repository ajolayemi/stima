import 'package:flutter/material.dart';
import 'package:stima/shared/constants/breakpoints.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_center_widget.dart';

/// Scrollable widget that shows a responsive card with a given child widget.
/// Useful for displaying forms and other widgets that need to be scrollable.
class ResponsiveScrollable extends StatelessWidget {
  const ResponsiveScrollable({
    super.key,
    required this.child,
    this.maxContentWidth,
    this.scrollController,
    this.scrollPhysics,
  });
  final Widget child;
  final double? maxContentWidth;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: scrollPhysics,
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth ?? Breakpoint.tablet,
        child: child,
      ),
    );
  }
}
