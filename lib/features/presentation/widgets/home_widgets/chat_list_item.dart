

import 'package:firebase_message/core/constants/colors/app_colors.dart';
import 'package:firebase_message/features/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/date_converter.dart';
import '../shimmer_image.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.user,
    this.notSeenCount = "",
    this.isOnline = false,
  });

  final UserEntity user;
  final String notSeenCount;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                ),
                child:ImageWithShimmer(imageUrl:'', width: 60, height: 60,)
              ),
              if(isOnline) Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 4, bottom: 2),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    width: 2,
                    color: AppColors.white,
                  )
                ),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(user.fullName!, style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                    overflow: TextOverflow.ellipsis,),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Text(user.lastMessageBody!,
                    style:  TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                      color: AppColors.darkGray),
                    overflow: TextOverflow.ellipsis,),
                ),
              ],
            )
          ),
          SizedBox(
            height: 60,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateConverter.getTimeString(user.lastSeenDateTime!),style:
                TextStyle(fontWeight: FontWeight.w500,fontSize: 12,
                    color: AppColors.darkGray,
                )
                  ,),
                if(notSeenCount.isNotEmpty) Container(
                    width: 25,
                    height: 25,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: AppColors.darkGreen,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Center(child: Text(notSeenCount,
                      style: const TextStyle(color: AppColors.white),))
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
