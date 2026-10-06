import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/chatbot/data/model/chatbot_model.dart';
import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';
import 'package:dartz/dartz.dart';

abstract class ChatbotPatientRepo {
  Future<Either<ErrorModel, ChatbotModel>> chatbotPatient({
    required String message,
    required List<ConversationHistory> conversationHistory,
  });
}
