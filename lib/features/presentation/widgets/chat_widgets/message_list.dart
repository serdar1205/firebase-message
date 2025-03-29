import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import 'date_label.dart';

class DemoMessageList extends StatelessWidget {
  const DemoMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
      child: ListView(
        children: [
          DateLabel(label: "Yesterday"),
          MessageTile(
              message: "Welcome!",
              messageDate: '07:00'),
          _MessageOwnTile(message: "Hi!", messageDate: '07:07'),
          MessageTile(
              message: "Do you want to be programmer? ", messageDate: '09:00'),
          _MessageOwnTile(message: "I think so", messageDate: '09:09'),


        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(
      {Key? key, required this.message, required this.messageDate})
      : super(key: key);

  final String message;
  final String messageDate;

  static double _borderRadius = 21;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.only(
          bottom: 20
        ),

        decoration: BoxDecoration(
            color: AppColors.stroke,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_borderRadius),
                topRight: Radius.circular(_borderRadius),
                bottomRight: Radius.circular(_borderRadius),

            ),
        ),
        child: Wrap(
          alignment: WrapAlignment.end,
          runAlignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text(message,
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14, color: AppColors.black,),),
           SizedBox(width: 9),
            Text(
              messageDate,
              style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12, color: AppColors.black,),),


          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  _MessageOwnTile({Key? key, required this.message, required this.messageDate})
      : super(key: key);

  String message;
  String messageDate;

  static double _borderRadius = 21;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: EdgeInsets.only(
              bottom: 20
          ),
          decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius))),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                    color: AppColors.darkGreen,
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
                        color: AppColors.darkGreen,),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.check,
                      size: 12,
                      color: AppColors.darkGreen,
                    )
                  ],
                ),


              ],
            ),
          )),
    );
  }
}






