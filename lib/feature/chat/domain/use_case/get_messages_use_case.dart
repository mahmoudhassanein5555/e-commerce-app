import 'package:e_commerce_app/feature/chat/domain/entites/message_entity.dart';
import 'package:e_commerce_app/feature/chat/domain/repositories/repo/chat_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMessagesUseCase {
  final ChatRepo _chatRepo;

  GetMessagesUseCase(this._chatRepo);

  Stream<List<MessageEntity>> invoke(String userId) {
    return _chatRepo.getMessages(userId);
  }
}
