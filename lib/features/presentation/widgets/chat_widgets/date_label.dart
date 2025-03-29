import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';

class DateLabel extends StatelessWidget {
  const DateLabel({super.key, required this.label});

 final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
     padding: EdgeInsets.only(bottom: 20),

      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1,
              color: AppColors.gray
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10), // Adjust spacing
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.gray
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
                color: AppColors.gray
            ),
          ),
        ],
      ),
    );
  }
}
