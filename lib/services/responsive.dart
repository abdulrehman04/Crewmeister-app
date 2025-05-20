import 'package:crewmeister_app/configs/configs.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  // screen sizes
  static bool isMobile() => AppMedia.width < AppBreakpoints.sm;

  static bool isTablet() =>
      AppMedia.width < AppBreakpoints.xmd &&
      AppMedia.width >= AppBreakpoints.sm;

  static bool isDesktop() => AppMedia.width >= AppBreakpoints.lg;

  // static bool isWideWeb() => kIsWeb && AppMedia.width >= AppBreakpoints.lg;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.lg) {
          return desktop;
        } else if (constraints.maxWidth >= AppBreakpoints.md) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
