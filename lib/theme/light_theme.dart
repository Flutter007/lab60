import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepOrange);
final defaultLightTheme = ThemeData.light();
final lightTheme = defaultLightTheme.copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.onPrimaryContainer,
    foregroundColor: lightColorScheme.primaryContainer,
  ),
  cardTheme: defaultLightTheme.cardTheme.copyWith(
    margin: EdgeInsets.all(4),
    color: lightColorScheme.surfaceBright,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  snackBarTheme: SnackBarThemeData(contentTextStyle: TextStyle(fontSize: 18)),
  textTheme: GoogleFonts.latoTextTheme(),
);
