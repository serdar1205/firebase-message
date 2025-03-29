import 'package:flutter/material.dart';

import '../../../domain/entities/user_entity.dart';
import '../shimmer_image.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key, required this.messageData});

  final UserEntity messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  spreadRadius: 0.3,
                  blurRadius: 4.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ImageWithShimmer(
              imageUrl: messageData.userAvatar!,
              width: 50,
              height: 50,
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
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Online",
              style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 12,),
            )
          ],
        ))
      ],
    );
  }
}
