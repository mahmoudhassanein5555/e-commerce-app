import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/feature/chat/domain/entites/attached_meta_data_entity.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? id;
  final AttachedMetaDataEntity? attachedMetaData;
  final bool isAdminSender;
  final String senderId;
  final String senderName;
  final String text;
  final Timestamp timestamp;

  const MessageEntity({
    this.id,
    this.attachedMetaData,
    required this.isAdminSender,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        attachedMetaData,
        isAdminSender,
        senderId,
        senderName,
        text,
        timestamp,
      ];
}
