import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  const MessageEntity({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        senderId,
        senderEmail,
        receiverId,
        message,
        timestamp,
      ];
}
