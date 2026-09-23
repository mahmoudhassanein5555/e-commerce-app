import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failure/failure.dart';
import 'package:e_commerce_app/feature/chat/domain/entites/message_entity.dart';
import 'package:e_commerce_app/feature/chat/domain/repositories/repo/chat_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendMessageUseCase {
  final ChatRepo _chatRepo;

  SendMessageUseCase(this._chatRepo);

  Future<Either<Failure, void>> invoke({
    required String userId,
    required String userName,
    required MessageEntity message,
  }) async {
    return await _chatRepo.sendMessage(
      userId: userId,
      userName: userName,
      message: message,
    );
  }
}
