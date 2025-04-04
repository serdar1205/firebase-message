import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:firebase_message/core/constants/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.isMyMessage,
    required this.message,
    required this.messageDate,
  });

  final String message;
  final String messageDate;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: isMyMessage ? AppColors.green : AppColors.stroke,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.messageBorderRadius),
                topRight: Radius.circular(AppSizes.messageBorderRadius),
                bottomLeft: isMyMessage
                    ? Radius.circular(AppSizes.messageBorderRadius)
                    : Radius.circular(0),
                bottomRight: isMyMessage
                    ? Radius.circular(0)
                    : Radius.circular(AppSizes.messageBorderRadius),
              )),
          child: Wrap(
            alignment: WrapAlignment.end,
            runAlignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isMyMessage ? AppColors.darkGreen : AppColors.black,
                ),
              ),
              SizedBox(width: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    messageDate,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color:
                      isMyMessage ? AppColors.darkGreen : AppColors.black,
                    ),
                  ),
                  if (isMyMessage)
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color:
                        isMyMessage ? AppColors.darkGreen : AppColors.black,
                      ),
                    )
                ],
              ),
            ],
          )),
    );
  }
}
