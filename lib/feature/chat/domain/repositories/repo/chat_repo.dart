import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/feature/chat/domain/entites/message_entity.dart';

abstract class ChatRepo {
  Stream<List<MessageEntity>> getMessages(String userId);
  
  Future<Either<Failure, void>> sendMessage({
    required String userId,
    required String userName,
    required MessageEntity message,
  });
}
