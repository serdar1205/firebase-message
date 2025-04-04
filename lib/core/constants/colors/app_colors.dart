import 'package:flutter/material.dart';

abstract class AppColors {
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const stroke = Color.fromRGBO(237, 242, 246, 1);//form
  static const gray = Color.fromRGBO(157, 183, 203, 1);//sobseniya
  static const darkGray = Color.fromRGBO(94, 122, 144, 1);//2 m nazad
  static const black = Color.fromRGBO(43, 51, 62, 1);//text
  static const green = Color.fromRGBO(60, 237, 120, 1);//box green
  static const darkGreen = Color.fromRGBO(0, 82, 28, 1);//text green


}



class AvatarColorHelper {
  static final List<Color> _avatarColors = [
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
    Color(0xFF3F51B5), // Indigo
    Color(0xFF2196F3), // Blue
    Color(0xFF00BCD4), // Cyan
    Color(0xFF4CAF50), // Green
    Color(0xFFFFC107), // Amber
    Color(0xFFFF5722), // Deep Orange
  ];

  static Color getColor(String seed) {
    final int hash = seed.hashCode;
    return _avatarColors[hash % _avatarColors.length];
  }
}

