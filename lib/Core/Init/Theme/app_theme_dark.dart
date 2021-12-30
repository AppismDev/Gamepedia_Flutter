import 'package:flutter/material.dart';
import 'package:gamepedia/Core/Init/Theme/i_app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeDark implements IAppTheme {
  static AppThemeDark _instance = AppThemeDark._init();

  static AppThemeDark get instance => _instance;

  AppThemeDark._init();

  @override
  ThemeData? themeData;

  ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
            secondary: Colors.red,
            primary: Color(0xffE50914)
        ),
        primaryColor: Colors.black,
        shadowColor: const Color(0xFF141414),
        backgroundColor: const Color(0xFF212121),
        dividerColor: Colors.black12,
        iconTheme: IconThemeData(color: Colors.white),
        primaryIconTheme: IconThemeData(color: Color(0xffE50914)),
        scaffoldBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          titleTextStyle: GoogleFonts.montserrat(fontSize: 14),
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.grey.shade900,
            actionTextColor: Colors.orangeAccent,
            contentTextStyle: GoogleFonts.montserrat(color: Colors.grey.shade200),
            behavior: SnackBarBehavior.floating),
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          headline1: GoogleFonts.montserrat(color: Colors.grey.shade200),
          headline2: GoogleFonts.montserrat(color: Colors.grey.shade200),
          headline3: GoogleFonts.montserrat(color: Colors.grey.shade200),
          headline4: GoogleFonts.montserrat(color: Colors.grey.shade200),
          headline5: GoogleFonts.montserrat(color: Colors.grey.shade200),
          headline6: GoogleFonts.montserrat(color: Colors.grey.shade200),
          subtitle1: GoogleFonts.montserrat(color: Colors.grey.shade200),
          subtitle2: GoogleFonts.montserrat(color: Colors.grey.shade200),
          bodyText1: GoogleFonts.montserrat(color: Colors.grey.shade200),
          bodyText2: GoogleFonts.montserrat(color: Colors.grey.shade200),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.grey.shade200,
              primary: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none
        ),
      );
}
