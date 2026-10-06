import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/chatbot/data/model/chatbot_model.dart';
import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';
import 'package:chefaa/features/patient/chatbot/domain/repository/chatbot_patient_repo.dart';
import 'package:dartz/dartz.dart';

class ChatbotPatientUsecase {
  final ChatbotPatientRepo repo;

  ChatbotPatientUsecase({required this.repo});

  Future<Either<ErrorModel, ChatbotModel>> call({
    required String message,
    required List<ConversationHistory> conversationHistory,
  }) async {
    return await repo.chatbotPatient(
      message: message,
      conversationHistory: conversationHistory,
    );
  }
}
