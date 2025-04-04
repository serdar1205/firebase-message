import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_message/features/data/models/user_model.dart';
import 'package:firebase_message/features/domain/usecases/user_usecases/report_user_usecase.dart';

abstract class UserRemoteDataSource {
  Stream<List<UserModel>> getAllUsers();

  Stream<List<UserModel>> getBlockedUsers();

  Future<void> reportUser(ReportUserParams params);

  Future<void> blockUser(String userId);

  Future<void> unBlockUser(String blockedUserId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl(
      {required this.firestore, required this.firebaseAuth});

  Stream<List<Map<String, dynamic>>> _getUsersStreamExcludingBlocked() {
    final currentUser = firebaseAuth.currentUser;

    return firestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection('blockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userSnapshot = await firestore.collection('users').get();

      return userSnapshot.docs
          .where((doc) =>
              doc.id != currentUser.uid && !blockedUserIds.contains(doc.id))
          .map((doc) => doc.data())
          .toList();
    });
  }

  @override
  Stream<List<UserModel>> getAllUsers() {
    return _getUsersStreamExcludingBlocked()
        .map((usersList) => usersList.map((data) {
              return UserModel(
                id: data['uid'],
                fullName: "${data['name']} ${data['surname']}",
                email: data['email'] ?? '',
              );
            }).toList());
  }

  Stream<List<Map<String, dynamic>>> _getBlockedUsersStream(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('blockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
      final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

      final userDocs = await Future.wait(blockedUserIds
          .map((id) => firestore.collection('users').doc(id).get()));

      return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  Stream<List<UserModel>> getBlockedUsers() {
    final currentUser = firebaseAuth.currentUser;

    return _getBlockedUsersStream(currentUser!.uid)
        .map((usersList) => usersList.map((data) {
              return UserModel(
                id: data['uid'],
                fullName: "${data['name']} ${data['surname']}",
                email: data['email'],
              );
            }).toList());
  }

  @override
  Future<void> blockUser(String userId) async {
    final currentUser = firebaseAuth.currentUser;
    await firestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection('blockedUsers')
        .doc(userId)
        .set({});
  }

  @override
  Future<void> reportUser(ReportUserParams params) async {
    final currentUser = firebaseAuth.currentUser;

    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': params.messageId,
      'messageOwnerId': params.userId,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await firestore.collection('reports').add(report);
  }

  @override
  Future<void> unBlockUser(String blockedUserId) async {
    final currentUser = firebaseAuth.currentUser;
    await firestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection('blockedUsers')
        .doc(blockedUserId)
        .delete();
  }
}
