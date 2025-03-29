// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:messenger/features/presentation/blocs/shared_cubit/theme_cubit/theme_cubit.dart';
//
// import 'app_theme.dart';
//
// class ThemeDetector {
//   const ThemeDetector();
//
//   static void init(BuildContext context) {
//     try {
//       _listen(context);
//       View.of(context).platformDispatcher.onPlatformBrightnessChanged = () {
//         _listen(context);
//       };
//     } catch (e) {
//       return;
//     }
//   }
//
//   static void _listen(context) {
//     final brightness = View.of(context).platformDispatcher.platformBrightness;
//     bool isDark = (brightness == Brightness.dark) ? true : false;
//     ThemeData themeData = isDark ? AppTheme.darkTheme() : AppTheme.lightTheme();
//     BlocProvider.of<ThemeCubit>(context).setThemeData(themeData, isDark);
//   }
// }
