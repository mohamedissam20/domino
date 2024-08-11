import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.green,
  floatingActionButtonTheme:
  const FloatingActionButtonThemeData(backgroundColor: Colors.green),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.grey),
      titleTextStyle: GoogleFonts.lato(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      elevation: 10,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.green,
    elevation: 20,
  ),
  textTheme:  TextTheme(
      labelSmall:
      GoogleFonts.lato(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
      labelMedium:
      GoogleFonts.lato(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
      labelLarge:
      GoogleFonts.lato(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold)
  ),
);