import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/model/pharmacy_chatbot/pharmacy_chatbot.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';
import 'package:dartz/dartz.dart';

abstract class ChatbotPharmacyRepo {
  Future<Either<ErrorModel, PharmacyChatbot>> pharmChatbot({
    required String question,
    required List<ChatHistory> history,
  });
}
