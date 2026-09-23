import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String? id;
  final bool isProductAttachment;
  final String lastMessageText;
  final Timestamp lastMessageTime;
  final String lastSenderId;
  final int unreadByAdminCount;
  final String userId;
  final String userName;

  ChatRoomModel({
    this.id,
    required this.isProductAttachment,
    required this.lastMessageText,
    required this.lastMessageTime,
    required this.lastSenderId,
    required this.unreadByAdminCount,
    required this.userId,
    required this.userName,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json, String documentId) {
    return ChatRoomModel(
      id: documentId,
      isProductAttachment: json['isProductAttachment'] ?? false,
      lastMessageText: json['lastMessageText'] ?? '',
      lastMessageTime: json['lastMessageTime'] as Timestamp? ?? Timestamp.now(),
      lastSenderId: json['lastSenderId'] ?? '',
      unreadByAdminCount: json['unreadByAdminCount'] as int? ?? 0,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isProductAttachment': isProductAttachment,
      'lastMessageText': lastMessageText,
      'lastMessageTime': lastMessageTime,
      'lastSenderId': lastSenderId,
      'unreadByAdminCount': unreadByAdminCount,
      'userId': userId,
      'userName': userName,
    };
  }
}
