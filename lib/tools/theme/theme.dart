import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/shapes.dart';
import 'colors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    dialogBackgroundColor: whiteColor,
    colorScheme:  ColorScheme.light(primary: primaryColor, background: backGroundColor),
    dialogTheme: DialogTheme(shape: getShapeWidget(15), elevation: 5),
    scaffoldBackgroundColor: backGroundColor,
    iconTheme:
        const IconThemeData().copyWith(color: darkColor, size: ScreenUtil().setWidth(19)),
    floatingActionButtonTheme:
         FloatingActionButtonThemeData(backgroundColor: primaryColor, elevation: 5),
    cardTheme: const CardTheme(color: whiteColor, elevation: 3),
    //
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: getShapeWidget(10),
        alignment: Alignment.center,
        backgroundColor: primaryColor,
        textStyle: TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'vazir',
          fontSize: ScreenUtil().setWidth(12),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: getShapeWidget(10),
        alignment: Alignment.center,
        textStyle: TextStyle(
          color: whiteColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'vazir',
          fontSize: ScreenUtil().setWidth(13),
        ),
      ),
    ),
    shadowColor: greyColor.withOpacity(0.6),
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      actionsIconTheme: const IconThemeData(color: darkColor),
      elevation: 1,
      iconTheme: const IconThemeData(color: darkColor),
      centerTitle: false,
      titleTextStyle: TextStyle(
          color: darkColor,
          fontFamily: 'vazir',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setWidth(12)),
    ),

    //
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: textFieldColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.5),
        gapPadding: 10,
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.5),
        gapPadding: 10,
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.5),
        gapPadding: 10,
        borderSide: BorderSide(color: darkColor.withOpacity(0.0), width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(7.5),
        borderSide: BorderSide(color: darkColor.withOpacity(0.0), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(7.5),
        borderSide: BorderSide(color: darkColor.withOpacity(0.0), width: 1),
      ),
      iconColor: darkColor,
      suffixIconColor: darkColor,
      labelStyle: TextStyle(
          fontFamily: 'vazir',
          color: darkColor.withOpacity(0.8),
          fontSize: ScreenUtil().setWidth(12)),
      hintStyle: TextStyle(
          fontFamily: 'vazir',
          color: darkColor.withOpacity(0.6),
          fontSize: ScreenUtil().setWidth(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),

    snackBarTheme: SnackBarThemeData(
      contentTextStyle: TextStyle(
          color: whiteColor,
          fontFamily: 'vazir',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setWidth(10)),
    ),
    //
    //
    //
    textTheme: TextTheme(
      bodySmall: TextStyle(
          fontFamily: 'vazir', color: darkColor, fontSize: ScreenUtil().setWidth(10)),
      bodyMedium: TextStyle(
          fontFamily: 'vazir', color: darkColor, fontSize: ScreenUtil().setWidth(12)),
      bodyLarge: TextStyle(
          fontFamily: 'vazir', color: darkColor, fontSize: ScreenUtil().setWidth(14)),
      //
      titleSmall: TextStyle(
          color: whiteColor,
          fontFamily: 'vazir',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setWidth(12)),
      titleMedium: TextStyle(
          color: darkColor,
          fontFamily: 'vazir',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setWidth(16)),
      titleLarge: TextStyle(
          color: whiteColor,
          fontFamily: 'vazir',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setWidth(16)),
      //
      labelSmall: TextStyle(
          color: darkColor,
          fontFamily: 'vazir',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setWidth(12)),
      labelMedium: TextStyle(
          color: primaryColor,
          fontFamily: 'vazir',
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setWidth(14)),
      labelLarge: TextStyle(
          color: Colors.grey[500], fontFamily: 'vazir', fontSize: ScreenUtil().setWidth(12)),
      //
      //
    ),
  );
}
