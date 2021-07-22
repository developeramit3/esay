import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'app_font_family.dart';

class AppThemes {
  AppThemes._();

  static Color _lightPrimaryColor = HexColor('#2c6bec');
  static const Color _lightPrimaryVariantColor = Colors.white;
  static const Color _lightSecondaryColor = Colors.green;
  static Color _lightOnPrimaryColor = Colors.black;
  static Color _lightButtonPrimaryColor = HexColor('#2c6bec');
  static Color _lightAppBarColor = HexColor('#2c6bec');
  static Color _lightIconColor = HexColor('#2c6bec');
  static Color _lightSnackBarBackgroundErrorColor = Colors.white;

  static final TextStyle _lightScreenHeadingTextStyle = TextStyle(
    fontSize: 20.0,
    color: _lightOnPrimaryColor,
    letterSpacing: -1.5,
  );
  static final TextStyle _lightScreenTaskNameTextStyle = TextStyle(
    fontSize: 16.0,
    color: _lightOnPrimaryColor,
    letterSpacing: -1.5,
  );
  static final TextStyle _lightScreenTaskDurationTextStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.grey,
    letterSpacing: -1.5,
  );
  static final TextStyle _lightScreenButtonTextStyle = TextStyle(
    fontSize: 14.0,
    color: _lightOnPrimaryColor,
    fontWeight: FontWeight.w500,
    letterSpacing: -1.5,
  );
  static final TextStyle _lightScreenCaptionTextStyle = TextStyle(
    fontSize: 12.0,
    color: _lightAppBarColor,
    fontWeight: FontWeight.w100,
  );

  static final TextTheme _lightTextTheme = TextTheme(
    headline5: _lightScreenHeadingTextStyle,
    bodyText2: _lightScreenTaskNameTextStyle,
    bodyText1: _lightScreenTaskDurationTextStyle,
    button: _lightScreenButtonTextStyle,
    headline6: _lightScreenTaskNameTextStyle,
    subtitle1: _lightScreenTaskNameTextStyle,
    caption: _lightScreenCaptionTextStyle,
  );

  static final ThemeData lightTheme = ThemeData(
    fontFamily: AppFontFamily.openSans,
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightButtonPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _lightAppBarColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      textTheme: _lightTextTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    snackBarTheme:
        SnackBarThemeData(backgroundColor: _lightSnackBarBackgroundErrorColor),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightAppBarColor),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
        buttonColor: _lightButtonPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: Colors.deepPurple,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: _lightPrimaryColor,
        labelStyle: TextStyle(
          color: Colors.black,
        )),
  );
}
