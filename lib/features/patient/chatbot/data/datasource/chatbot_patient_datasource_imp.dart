import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/chatbot/data/datasource/chatbot_patient_datasource.dart';
import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';

class ChatbotPatientDatasourceImp implements ChatbotPatientDatasource {
  final ApiConsumer api;

  ChatbotPatientDatasourceImp({required this.api});

  @override
  Future<dynamic> chatbotPatient({
    required String message,
    required List<ConversationHistory> conversationHistory,
  }) async {
    final response = await api.post(
      ApiEndpoints.chatbotPatient,
      data: {
        "message": message,
        "conversationHistory": conversationHistory
            .map((e) => e.toMap())
            .toList(),
      },
    );
    return response;
  }
}