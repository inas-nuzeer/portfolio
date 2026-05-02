import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 1. Define your Color Palette
  static const Color _primaryColor = Color(0xFFfeb800); // Your brand color
  static const Color _secondaryColor = Color(0xFF2B2B2B); // Dark text/bg
  static const Color _backgroundColor = Color(0xFFF8F9FA); // Light bg

  static ThemeData lightTheme = ThemeData(
    // 2. Set the Color Scheme (Replaces primarySwatch)
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: _backgroundColor,
    ),

    // 3. Set Global Font Family (Fallback)
    fontFamily: 'Inter', // If Google Fonts fails, it falls back to this
    // 4. Customize the Text Theme
    textTheme: TextTheme(
      // Headline 1 (Your Name/Hero Title)
      displayLarge: GoogleFonts.poppins(
        fontSize: 116,
        fontWeight: FontWeight.w600,
        color: _backgroundColor,
      ),
      // Headline 2 (Section Titles)
      headlineMedium: GoogleFonts.poppins(
        fontSize: 56,
        fontWeight: FontWeight.w500,
        color: _primaryColor,
      ),
      // Body Text (Descriptions)
      bodyLarge: GoogleFonts.inter(
        fontSize: 20,
        color: _backgroundColor,
        height: 1.5,
      ),
      // Button Text
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),

    // 5. Style AppBar & Buttons (Optional but recommended)
    appBarTheme: AppBarTheme(
      backgroundColor: _backgroundColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _secondaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
        backgroundColor: _secondaryColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
