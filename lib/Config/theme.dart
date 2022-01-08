import 'package:flutter/material.dart';

Color _background = const Color(0xffE8EDF5);
Color _accent = const Color(0xff050505);
Color _backgroundSecondary = Colors.white;
Color _secondary = const Color(0xffB4BECC);
Color _primary = const Color(0xff354250);
Color _primaryLight = const Color(0xff717987);

class ThemeMPlex {
  static ThemeData light = ThemeData(
      focusColor: _primaryLight,
      accentColor: _background,
      applyElevationOverlayColor: true,
      dividerColor: _secondary,
      iconTheme: IconThemeData(color: _primary, size: 20),
      textTheme: TextTheme(
          bodyText2: ThemeData.light()
              .textTheme
              .bodyText2!
              .copyWith(fontFamily: "Source Sans Pro")),
      scaffoldBackgroundColor: _background,
      primaryColor: _primary,
      backgroundColor: _backgroundSecondary,
      appBarTheme: AppBarTheme(
          backgroundColor: _background,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontFamily: "Heebo",
              color: _accent,
              fontSize: 30,
              fontWeight: FontWeight.w500)));
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: ThemeData.dark().iconTheme.color, size: 20),
  );
}
