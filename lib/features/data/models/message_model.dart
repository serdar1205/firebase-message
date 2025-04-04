import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_message/features/domain/entities/message_entity.dart';

class MessageModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      senderId: data['senderId'],
      senderEmail: data['senderEmail'],
      receiverId: 'receiverId',
      message: data['message'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      senderId: senderId,
      senderEmail: senderEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );
  }
}
