part of './utils.dart';

BoxShadow boxShad(double x, double y, double blur) {
  return BoxShadow(
    offset: Offset(x, y),
    blurRadius: blur,
    color: Color(0xff000000).withSafeOpacity(0.2),
  );
}
