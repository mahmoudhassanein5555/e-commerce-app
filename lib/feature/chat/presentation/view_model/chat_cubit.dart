import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/feature/chat/data/models/attached_meta_data_model.dart';
import 'package:e_commerce_app/feature/chat/data/models/message_model.dart';
import 'package:e_commerce_app/feature/chat/data/repository/chat_repository.dart';
import 'package:e_commerce_app/feature/chat/presentation/view_model/chat_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _messagesSubscription;
  String _userId = '';
  String _userName = '';

  ChatCubit(this._chatRepository) : super(ChatInitial());

  void initChat(String userId, String userName) {
    _userId = userId;
    _userName = userName;
    
    emit(ChatLoading());
    _messagesSubscription?.cancel();
    _messagesSubscription = _chatRepository.getMessages(_userId).listen(
      (messages) {
        emit(ChatLoaded(messages));
      },
      onError: (error) {
        emit(ChatError(error.toString()));
      },
    );
  }

  Future<void> sendMessage(String text, {AttachedMetaDataModel? attachedData}) async {
    if (text.trim().isEmpty && attachedData == null) return;
    if (_userId.isEmpty) return;

    final message = MessageModel(
      isAdminSender: false,
      senderId: _userId,
      senderName: _userName,
      text: text.trim(),
      timestamp: Timestamp.now(),
      attachedMetaData: attachedData,
    );

    try {
      await _chatRepository.sendMessage(
        userId: _userId,
        userName: _userName,
        message: message,
      );
    } catch (e) {
      // Could emit an error, but stream handles UI mostly.
      // Might want to handle send error explicitly if needed.
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
