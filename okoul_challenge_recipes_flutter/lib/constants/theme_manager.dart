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
    // Colors
    // primaryColor: ColorsManager.primary,
    // primaryColorLight: ColorsManager.lightPrimary,
    // primaryColorDark: ColorsManager.error,
    // disabledColor: ColorsManager.lightGrey,
    // splashColor: ColorsManager.lightPrimary,
    // card theme


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
    // button theme
    // buttonTheme: ButtonThemeData(
    //   // buttonColor: ColorsManager.primary,
    //   // disabledColor: ColorsManager.grey1,
    //   // highlightColor: ColorsManager.lightPrimary,
    //   // splashColor: ColorsManager.lightPrimary,
    //   textTheme: ButtonTextTheme.primary,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(Sizes.p12),
    //   ),
    // ),
    // Text theme
    // textButtonTheme: TextButtonThemeData(
    //   style: TextButton.styleFrom(
    //     textStyle: getRegularStyle(
    //       color: ColorsManager.primary,
    //       fontSize: FontsManager.size16,
    //     ),
    //     foregroundColor: ColorsManager.primary,
    //     backgroundColor: ColorsManager.white,
    //   ),
    // ),
    // elevated button theme
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     textStyle: getRegularStyle(
    //       color: ColorsManager.white,
    //       fontSize: FontsManager.size20,
    //     ),
    //     foregroundColor: ColorsManager.white,
    //     backgroundColor: ColorsManager.primary,
    //     elevation: Sizes.p4,
    //     shadowColor: ColorsManager.lightPrimary,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(Sizes.p12),
    //     ),
    //   ),
    // ),
    // Text theme
//https://api.flutter.dev/flutter/material/TextTheme-class.html
// see this link to see the available text manager
    // textTheme: TextTheme(
    //     // For heading
    //     displayLarge: getSemiBoldStyle(
    //       color: ColorsManager.darkGrey,
    //       fontSize: FontsManager.size22,
    //     ),
    //     // For subtitle
    //     headlineMedium: getMediumStyle(
    //       color: ColorsManager.lightGrey,
    //       fontSize: FontsManager.size16,
    //     ),
    //     // For caption
    //     titleMedium: getRegularStyle(color: ColorsManager.grey),
    //     // For text
    //     bodySmall: getRegularStyle(
    //         color: ColorsManager.grey, fontSize: FontsManager.size16)),

    // For the text input
    // inputDecorationTheme: InputDecorationTheme(
    //   // Padding
    //   contentPadding: const EdgeInsets.all(Sizes.p16),
    // Styles
    // hintStyle: getRegularStyle(
    //     color: ColorsManager.lightGrey, fontSize: FontsManager.size16),
    // labelStyle: getMediumStyle(
    //     color: ColorsManager.grey, fontSize: FontsManager.size16),
    // errorStyle: getRegularStyle(
    //     color: ColorsManager.error, fontSize: FontsManager.size16),
    // Border
    // Border the users does not click on the field
    // enabledBorder: const OutlineInputBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(Sizes.p12)),
    //   borderSide: BorderSide(color: ColorsManager.lightGrey, width: Sizes.p1),
    // ),
    // // Border the users does  click on the field
    // focusedBorder: const OutlineInputBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(Sizes.p12)),
    //   borderSide: BorderSide(color: ColorsManager.primary),
    // ),
    // // Border on the error input and the user does not click on it
    // errorBorder: const OutlineInputBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(Sizes.p12)),
    //   borderSide: BorderSide(color: ColorsManager.error),
    // ),
    // // Border on the error input and the user click on it
    // focusedErrorBorder: const OutlineInputBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(Sizes.p12)),
    //   borderSide: BorderSide(color: ColorsManager.primary),
    // ),
    // ),
  );
}
