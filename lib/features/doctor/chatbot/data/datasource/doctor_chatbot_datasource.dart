import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';

abstract class DoctorChatbotDatasource {
  Future<dynamic> doctorChatbot({
    required String message,
    required List<ChatHistory> history,
  });
}
