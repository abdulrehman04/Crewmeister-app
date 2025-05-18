import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppHeading extends StatelessWidget {
  const AppHeading({super.key, required this.heading});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        heading,
        style: GoogleFonts.archivo(fontWeight: FontWeight.w800, fontSize: 40),
      ),
    );
  }
}
