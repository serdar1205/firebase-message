import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../domain/entities/user_entity.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.messageData});

  final UserEntity messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AvatarColorHelper.getColor(
              messageData.fullName ?? messageData.email!),
          child: Text(
            messageData.fullName![0].toUpperCase(),
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageData.fullName!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Online",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            )
          ],
        ))
      ],
    );
  }
}
