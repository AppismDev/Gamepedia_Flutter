import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:gamepedia/Core/Init/Theme/i_app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
//TODO snackbarlarda tema sorunu var bakılacak
class AppThemeLight implements IAppTheme{
  static AppThemeLight _instance = AppThemeLight._init();
  static AppThemeLight get instance => _instance;

  AppThemeLight._init();

  @override
  ThemeData? themeData;

  ThemeData get theme => ThemeData(
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light)
        .copyWith(secondary:  Color(0xffE50914)),
    primaryColor: Color(0xffE50914),
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.black
    ),
    primaryIconTheme: IconThemeData(
      color: Color(0xffE50914)
    ),
    scaffoldBackgroundColor: Color(0xffF4F4F4),
    shadowColor: const Color(0xFF141414),
    backgroundColor: const Color(0xFF212121),
    dividerColor: Colors.black12,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.grey.shade800),
      elevation: 0,
      centerTitle: true,
      // backgroundColor:  Color(0xffE50914),
      backgroundColor: Color(0xffF4F4F4),
      toolbarTextStyle: GoogleFonts.montserrat(color: Colors.black),
      titleTextStyle: GoogleFonts.montserrat(fontSize: 14, color: Colors.black),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey.shade900,
        actionTextColor: Colors.orangeAccent,
        contentTextStyle: GoogleFonts.montserrat(color: Colors.black),
        behavior: SnackBarBehavior.floating),
    textTheme: GoogleFonts.montserratTextTheme().copyWith(
      headline1: GoogleFonts.montserrat(color: Colors.black),
      headline2: GoogleFonts.montserrat(color: Colors.black),
      headline3: GoogleFonts.montserrat(color: Colors.black),
      headline4: GoogleFonts.montserrat(color: Colors.black),
      headline5: GoogleFonts.montserrat(color: Colors.black),
      headline6: GoogleFonts.montserrat(color: Colors.black),
      subtitle1: GoogleFonts.montserrat(color: Colors.grey.shade700),
      subtitle2: GoogleFonts.montserrat(color: Colors.grey.shade700),
      bodyText1: GoogleFonts.montserrat(color: Colors.black),
      bodyText2: GoogleFonts.montserrat(color: Colors.black),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(onPrimary: Colors.grey.shade800, primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      labelStyle: TextStyle(
        fontSize: 35,
        decorationColor: Colors.red,
      ),
      fillColor: Colors.grey.withOpacity(0.1),
      filled: true,
    ),
  );


}