import 'package:flutter/material.dart';

// Centralized app colors to keep UI consistent
const Color kPrimaryBlue = Color(0xFF1976D2); // Material Blue 700-ish

/// A grayscale color matrix used with ColorFilter.matrix to turn images into
/// black-and-white (desaturated) backgrounds.
const List<double> kGreyscaleMatrix = <double>[
  0.2126, 0.7152, 0.0722, 0, 0, // red
  0.2126, 0.7152, 0.0722, 0, 0, // green
  0.2126, 0.7152, 0.0722, 0, 0, // blue
  0, 0, 0, 1, 0, // alpha
];

ThemeData appTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryBlue),
    primaryColor: kPrimaryBlue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: base.textTheme.apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
    dialogBackgroundColor: Colors.white,
  );
}
