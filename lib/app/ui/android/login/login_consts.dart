import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kHintTextStyle = GoogleFonts.openSans(
  color: Colors.white54,
);

var kLabelStyle = GoogleFonts.openSans(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
