import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../constants/strings/text_fonts.dart';
import '../routes/animated_page_route.dart';


class AppTheme {
  const AppTheme();

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
    TargetPlatform.android: CustomOpenUpwardsPageTransitionsBuilder(),
    },
    ),
    fontFamily: TextFonts.gilroy,
    appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    shadowColor: Colors.white,
    scrolledUnderElevation: 0,

    )
    );
  }

}
