import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/feature/chat/data/models/chat_room_model.dart';
import 'package:e_commerce_app/feature/chat/data/models/message_model.dart';
import 'package:injectable/injectable.dart';

abstract class ChatRepository {
  Stream<List<MessageModel>> getMessages(String userId);
  Future<void> sendMessage({
    required String userId,
    required String userName,
    required MessageModel message,
  });
}

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<MessageModel>> getMessages(String userId) {
    return _firestore
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  @override
  Future<void> sendMessage({
    required String userId,
    required String userName,
    required MessageModel message,
  }) async {
    final chatDocRef = _firestore.collection('chats').doc(userId);
    final messagesCollectionRef = chatDocRef.collection('messages');

    // Add the message to the subcollection
    await messagesCollectionRef.add(message.toJson());

    // We can't directly cast FieldValue.increment(1) to int, so let's use a map update
    await chatDocRef.set({
      'isProductAttachment': message.attachedMetaData != null,
      'lastMessageText': message.text,
      'lastMessageTime': message.timestamp,
      'lastSenderId': message.senderId,
      'unreadByAdminCount': FieldValue.increment(1),
      'userId': userId,
      'userName': userName,
    }, SetOptions(merge: true));
  }
}
