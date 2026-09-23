import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/feature/chat/data/models/attached_meta_data_model.dart';

class MessageModel {
  final String? id;
  final AttachedMetaDataModel? attachedMetaData;
  final bool isAdminSender;
  final String senderId;
  final String senderName;
  final String text;
  final Timestamp timestamp;

  MessageModel({
    this.id,
    this.attachedMetaData,
    required this.isAdminSender,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String documentId) {
    return MessageModel(
      id: documentId,
      attachedMetaData: json['attachedMetaData'] != null
          ? AttachedMetaDataModel.fromJson(
              json['attachedMetaData'] as Map<String, dynamic>)
          : null,
      isAdminSender: json['isAdminSender'] ?? false,
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      text: json['text'] ?? '',
      timestamp: json['timestamp'] as Timestamp? ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (attachedMetaData != null)
        'attachedMetaData': attachedMetaData!.toJson(),
      'isAdminSender': isAdminSender,
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
