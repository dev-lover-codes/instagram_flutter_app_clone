import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

// These must be final (not const) because GoogleFonts.inter() is not a const function
TextStyle get kHeading => GoogleFonts.inter(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: kTextPrimary,
);

TextStyle get kSubheading => GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kTextPrimary,
);

TextStyle get kBodyBold => GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: kTextPrimary,
);

TextStyle get kBody => GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: kTextPrimary,
);

TextStyle get kCaption => GoogleFonts.inter(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: kTextPrimary,
);

TextStyle get kCaptionBold => GoogleFonts.inter(
  fontSize: 13,
  fontWeight: FontWeight.w600,
  color: kTextPrimary,
);

TextStyle get kSmall => GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: kTextPrimary,
);

TextStyle get kTiny => GoogleFonts.inter(
  fontSize: 11,
  fontWeight: FontWeight.w400,
  color: kTextSecondary,
);
