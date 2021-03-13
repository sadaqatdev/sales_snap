import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final customColorOne = Color(0xffA2AEBC);

  static final customColorTwo = Color(0xffF5820D);

  static final customColorThree = Color(0xff24B4D6);

  static final themeData = ThemeData(
    primaryColor: Color(0xff24B4D6),
    backgroundColor: Color(0xffE7E9EF),
    textTheme: TextTheme(
      headline1: GoogleFonts.rubik().copyWith(
          fontSize: 28,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal),
      headline2: GoogleFonts.rubik().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontStyle: FontStyle.normal),
      bodyText2: GoogleFonts.alegreya()
          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
      bodyText1: GoogleFonts.rubik().copyWith(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.rubik()
          .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
      unselectedLabelStyle: GoogleFonts.alegreya().copyWith(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF9F9F9F),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(
        fontSize: 12.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF9F9F9F),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  );
}
