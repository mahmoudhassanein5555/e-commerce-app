import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatRoomEntity extends Equatable {
  final String? id;
  final bool isProductAttachment;
  final String lastMessageText;
  final Timestamp lastMessageTime;
  final String lastSenderId;
  final int unreadByAdminCount;
  final String userId;
  final String userName;

  const ChatRoomEntity({
    this.id,
    required this.isProductAttachment,
    required this.lastMessageText,
    required this.lastMessageTime,
    required this.lastSenderId,
    required this.unreadByAdminCount,
    required this.userId,
    required this.userName,
  });

  @override
  List<Object?> get props => [
        id,
        isProductAttachment,
        lastMessageText,
        lastMessageTime,
        lastSenderId,
        unreadByAdminCount,
        userId,
        userName,
      ];
}
