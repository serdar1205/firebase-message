import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/features/data/models/message_model.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/get_message_usecase.dart';
import 'package:firebase_message/features/domain/usecases/message_usecases/send_message_usecase.dart';

abstract class MessageRemoteDatasource {
  Stream<List<MessageModel>> getMessage(MessageParams params);

  Future<void> sendMessage(SendMessageParams prams);
}

class MessMessageRemoteDatasourceImpl implements MessageRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  MessMessageRemoteDatasourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Stream<List<MessageModel>> getMessage(MessageParams params) {
    return _getMessagesStream(params).map((message) => message.docs
        .map((doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<QuerySnapshot> _getMessagesStream(MessageParams params) {
    //construct chat room id for 2 users
    final List<String> ids = [params.userId, params.otherUserId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Future<void> sendMessage(SendMessageParams params) async {
    try {
      final String? currentUserId = firebaseAuth.currentUser?.uid;
      final String? currentUserEmail = firebaseAuth.currentUser?.email;

      if (currentUserId == null || currentUserEmail == null) {
        print("Error: User not authenticated");
        return;
      }

      final Timestamp timestamp = Timestamp.now();

      MessageModel newMessage = MessageModel(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: params.receiverId,
        message: params.message,
        timestamp: timestamp,
      );

      List<String> ids = [currentUserId, params.receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      await firestore
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());

      print("Message sent successfully to chat room: $chatRoomId");
    } catch (e) {
      print("Error sending message: $e");
    }
  }

}
