import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'colors_manager.dart';
import 'styles_manager.dart';

final getAppThemeProvider = Provider<ThemeData>((ref) {
  return getAppTheme();
});
ThemeData getAppTheme() {
  return ThemeData(
    fontFamily: 'Poppins',
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
    scaffoldBackgroundColor: ColorsManager.backGroundApp,

    // appBar theme
    appBarTheme: AppBarTheme(
        color: ColorsManager.backGroundApp,
        elevation: 0,
        // For status bar (TOP thing that contain the battery,...)
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorsManager.backGroundApp,
            statusBarIconBrightness: Brightness.light),
        titleTextStyle: getTitleStyle(
          color: ColorsManager.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),

    inputDecorationTheme: InputDecorationTheme(
      // Padding
      contentPadding: const EdgeInsets.only(left: 25.0, top: 15.0),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: ColorsManager.white, width: 1),
      ),
      // Border the users does  click on the field
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: ColorsManager.white),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
