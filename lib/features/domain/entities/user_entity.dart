import 'package:equatable/equatable.dart';


class UserEntity extends Equatable {
  const UserEntity({
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

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    lastSeenDateTime,
    lastMessageBody,
    lastMessageDateTime,
    lastMessageCategory,
    lastMessageType,
    lastMessageIsReadByTargetUser,
    isConfirm,
    notReadMessageCount,
  ];

}

