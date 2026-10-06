import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';

abstract class ChatbotPatientDatasource {
  Future<dynamic> chatbotPatient({
    required String message,
    required List<ConversationHistory> conversationHistory,
  });
}
