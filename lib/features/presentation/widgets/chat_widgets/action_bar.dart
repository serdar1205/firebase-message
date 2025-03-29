import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:firebase_message/core/constants/strings/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'k_textfield.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final typeCtrl = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: 80,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.stroke),
            child: SvgPicture.asset(IconsAssets.attach),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: KTextField(
                  controller: typeCtrl,
                  isSubmitted: false,
                  hintText: "Сообщение",
                )),
          ),
          // Padding(
          Container(
            padding: EdgeInsets.all(11),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.stroke),
            child: SvgPicture.asset(IconsAssets.microphone),
          ),
        ],
      ),
    );
  }
}
