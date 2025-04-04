// import 'package:messenger/objectbox.g.dart';
// import 'package:objectbox/objectbox.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import '../../../domain/entities/message_entity.dart';
// import '../../../domain/entities/user_entity.dart';
//
// class DatabaseHelper {
//   static DatabaseHelper? _databaseHelper;
//
//   DatabaseHelper._instance() {
//     _databaseHelper = this;
//   }
//
//   factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();
//
//   static Store? _store;
//
//   Future<Store> _create() async {
//     final appDir = await getApplicationDocumentsDirectory();
//     final dbPath = path.join(appDir.path, "MessengerObjectBox");
//     final store = await openStore(directory: dbPath);
//     return store;
//   }
//
//   void close() async {
//     try {
//       _store?.close();
//     } catch (e) {
//       return;
//     }
//   }
//
//   Future<Store?> get store async {
//     _store ??= await _create();
//     return _store;
//   }
//
//   /// ////////////////////////
//   /// User Store Functions ///
//   /// ////////////////////////
//
//   Future<bool> existUserLocal(String userPhoneNumber) async {
//     final db = await store;
//     final query = db!
//         .box<UserEntity>()
//         .query(UserEntity_.userPhoneNumber.equals(userPhoneNumber))
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     return results.isNotEmpty;
//   }
//
//   Future<List<UserEntity>> getAllUsersLocal() async {
//     final db = await store;
//     final query =
//         db!.box<UserEntity>().query().order(UserEntity_.fullName).build();
//     final results = await query.findAsync();
//     query.close();
//     return results;
//   }
//
//   Future<UserEntity> getUserLocal(String userPhoneNumber) async {
//     final db = await store;
//     final query = db!
//         .box<UserEntity>()
//         .query(UserEntity_.userPhoneNumber.equals(userPhoneNumber))
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     return results[0];
//   }
//
//   Future<bool> removeUserLocal(String userPhoneNumber) async {
//     final db = await store;
//     final query = db!
//         .box<UserEntity>()
//         .query(UserEntity_.userPhoneNumber.equals(userPhoneNumber))
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     await db.box<UserEntity>().removeAsync(results[0].id!);
//     return true;
//   }
//
//   Future<bool> saveUserLocal(UserEntity userItem) async {
//     final db = await store;
//     await db!.box<UserEntity>().putAsync(userItem, mode: PutMode.put);
//     return true;
//   }
//
//   /// ///////////////////////////
//   /// Message Store Functions ///
//   /// ///////////////////////////
//
//   Future<bool> existMessageLocal(String messageId) async {
//     final db = await store;
//     final query = db!
//         .box<MessageEntity>()
//         .query(MessageEntity_.messageId.equals(messageId))
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     return results.isNotEmpty;
//   }
//
//   Future<List<MessageEntity>> getAllMessagesLocal(
//       String senderPhoneNumber, String targetPhoneNumber) async {
//     final db = await store;
//     final query = db!
//         .box<MessageEntity>()
//         .query(
//           MessageEntity_.senderPhoneNumber.equals(senderPhoneNumber).and(
//                   MessageEntity_.targetPhoneNumber.equals(targetPhoneNumber)) |
//               MessageEntity_.senderPhoneNumber.equals(targetPhoneNumber).and(
//                   MessageEntity_.targetPhoneNumber.equals(senderPhoneNumber)),
//         )
//         .order(MessageEntity_.id, flags: Order.descending)
//         .build();
//     //
//     //
//     final results = await query.findAsync();
//     query.close();
//     return results;
//   }
//
//   Future<MessageEntity> getMessageLocal(String messageId) async {
//     final db = await store;
//     final query = db!
//         .box<MessageEntity>()
//         .query(MessageEntity_.messageId.equals(messageId))
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     return results[0];
//   }
//
//   Future<bool> removeMessageLocal(String messageId) async {
//     final db = await store;
//     final query = db!
//         .box<MessageEntity>()
//         .query(MessageEntity_.messageId.equals(messageId))
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     await db.box<MessageEntity>().removeAsync(results[0].id!);
//     return true;
//   }
//
//   Future<bool> saveMessageLocal(MessageEntity messageItem) async {
//     final db = await store;
//     await db!.box<MessageEntity>().putAsync(messageItem, mode: PutMode.insert);
//     return true;
//   }
//
//   Future<List<MessageEntity>> getAllUnsendMessagesLocal() async {
//     final db = await store;
//     final query = db!
//         .box<MessageEntity>()
//         .query(MessageEntity_.messageType.equals("sending"))
//         .order(MessageEntity_.id, flags: Order.descending)
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     return results;
//   }
//
//   Future<List<MessageEntity>> getAllNotReadMessagesLocal(
//       String senderPhoneNumber, String targetPhoneNumber) async {
//     final db = await store;
//     final query = db!
//         .box<MessageEntity>()
//         .query(
//           MessageEntity_.senderPhoneNumber.equals(senderPhoneNumber) &
//               MessageEntity_.targetPhoneNumber.equals(targetPhoneNumber) &
//               MessageEntity_.messageType.equals("received") &
//               MessageEntity_.messageIsReadByTargetUser.equals(false),
//         )
//         .order(MessageEntity_.id, flags: Order.descending)
//         .build();
//     final results = await query.findAsync();
//     query.close();
//     return results;
//   }
//
//
// }
