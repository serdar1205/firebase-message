import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.buttonTile,
    required this.onPressed,
    required this.isLoading,
  });

  final String buttonTile;
  final bool isLoading;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 50),
          decoration: BoxDecoration(
              color: AppColors.darkGreen,
              borderRadius: BorderRadius.circular(12)),
          child: isLoading
              ? const SizedBox(
            height: 23,
            width: 23,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColors.white,
              strokeWidth: 2,
            ),
          )
              :   Text(
            buttonTile,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          )),
    );
  }
}
