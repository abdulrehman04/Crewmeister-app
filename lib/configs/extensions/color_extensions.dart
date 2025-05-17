import 'dart:ui';

extension ColorExtension on Color {
  withSafeOpacity(double opacity) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    return withAlpha((opacity * 255).round());
  }
}
