import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/chatbot/data/datasource/chatbot_patient_datasource.dart';
import 'package:chefaa/features/patient/chatbot/data/model/chatbot_model.dart';
import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';
import 'package:chefaa/features/patient/chatbot/domain/repository/chatbot_patient_repo.dart';
import 'package:dartz/dartz.dart';

class ChatbotPatientRepoImp implements ChatbotPatientRepo {
  final ChatbotPatientDatasource datasource;

  ChatbotPatientRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, ChatbotModel>> chatbotPatient({
    required String message,
    required List<ConversationHistory> conversationHistory,
  }) async {
    try {
      final response = await datasource.chatbotPatient(
        message: message,
        conversationHistory: conversationHistory,
      );

      final chatbotModel = ChatbotModel.fromMap(response as Map<String, dynamic>);
      return Right(chatbotModel);
    } catch (e) {
      return Left(
        ErrorModel(
          message: e.toString(),
        ),
      );
    }
  }
}