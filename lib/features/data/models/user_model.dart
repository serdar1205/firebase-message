import 'package:firebase_message/features/domain/entities/user_entity.dart';

class UserModel {
  const UserModel({
    this.id,
    this.userPhoneNumber,
    this.fullName,
    this.userAvatar,
    this.lastSeenDateTime,
    this.lastMessageBody,
    this.lastMessageDateTime,
    this.lastMessageCategory,
    this.lastMessageType,
    this.lastMessageIsReadByTargetUser,
    this.isConfirm,
    this.notReadMessageCount,
    this.verifyCode,
    this.verifyProfile,
  });

  final int? id;
  final String? userPhoneNumber;
  final String? fullName;
  final String? userAvatar;
  final String? lastSeenDateTime;
  final String? lastMessageBody;
  final String? lastMessageDateTime;
  final String? lastMessageCategory;
  final String? lastMessageType;
  final bool? lastMessageIsReadByTargetUser;
  final bool? isConfirm;
  final int? notReadMessageCount;
  final String? verifyCode;
  final bool? verifyProfile;

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      userPhoneNumber: userPhoneNumber,
      fullName: fullName,
      userAvatar: userAvatar,
      lastSeenDateTime: lastSeenDateTime,
      lastMessageBody: lastMessageBody,
      lastMessageDateTime: lastMessageDateTime,
      lastMessageCategory: lastMessageCategory,
      lastMessageType: lastMessageType,
      lastMessageIsReadByTargetUser: lastMessageIsReadByTargetUser,
      isConfirm: isConfirm,
      notReadMessageCount: notReadMessageCount,
      verifyCode: verifyCode,
      verifyProfile: verifyProfile,
    );
  }
}
