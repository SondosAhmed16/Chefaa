import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';

abstract class PharmacyChatbotDatasource {
  Future<dynamic> pharmChatbot({
    required String question,
    required List<ChatHistory> history,
  });
}
