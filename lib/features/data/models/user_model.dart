import 'package:firebase_message/features/domain/entities/user_entity.dart';

class UserModel {
  const UserModel({
    this.id,
    this.fullName,
    this.email,
    this.lastSeenDateTime,
    this.lastMessageBody,
    this.lastMessageDateTime,
    this.lastMessageCategory,
    this.lastMessageType,
    this.lastMessageIsReadByTargetUser,
    this.isConfirm,
    this.notReadMessageCount,
  });

  final String? id;
  final String? fullName;
  final String? email;
  final String? lastSeenDateTime;
  final String? lastMessageBody;
  final String? lastMessageDateTime;
  final String? lastMessageCategory;
  final String? lastMessageType;
  final bool? lastMessageIsReadByTargetUser;
  final bool? isConfirm;
  final int? notReadMessageCount;

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      lastSeenDateTime: lastSeenDateTime,
      lastMessageBody: lastMessageBody,
      lastMessageDateTime: lastMessageDateTime,
      lastMessageCategory: lastMessageCategory,
      lastMessageType: lastMessageType,
      lastMessageIsReadByTargetUser: lastMessageIsReadByTargetUser,
      isConfirm: isConfirm,
      notReadMessageCount: notReadMessageCount,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'lastSeenDateTime': lastSeenDateTime,
        'lastMessageBody': lastMessageBody,
        'lastMessageDateTime': lastMessageDateTime,
        'lastMessageCategory': lastMessageCategory,
        'lastMessageType': lastMessageType,
        'lastMessageIsReadByTargetUser': lastMessageIsReadByTargetUser,
        'isConfirm': isConfirm,
        'notReadMessageCount': notReadMessageCount,
      };
}
