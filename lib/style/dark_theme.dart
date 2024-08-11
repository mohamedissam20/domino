import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.green,
  floatingActionButtonTheme:
  const FloatingActionButtonThemeData(backgroundColor: Colors.green),
  scaffoldBackgroundColor: Colors.black.withOpacity(.5),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.grey[300]),
      titleTextStyle: GoogleFonts.lato(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor:Colors.black.withOpacity(.8),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black.withOpacity(.8),
        statusBarIconBrightness: Brightness.light,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.green,
    elevation: 20,
  ),
  textTheme: TextTheme(
    labelSmall:
    GoogleFonts.lato(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
    labelMedium:
    GoogleFonts.lato(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
    labelLarge:
    GoogleFonts.lato(fontSize: 21,color: Colors.white,fontWeight: FontWeight.bold)
  ),
);