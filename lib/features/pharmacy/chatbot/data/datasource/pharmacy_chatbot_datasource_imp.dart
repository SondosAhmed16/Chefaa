import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/datasource/pharmacy_chatbot_datasource.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';

class PharmacyChatbotDatasourceImp implements PharmacyChatbotDatasource {
  final ApiConsumer api;

  PharmacyChatbotDatasourceImp({required this.api});

  @override
  Future<dynamic> pharmChatbot({
    required String question,
    required List<ChatHistory> history,
  }) async {
    return await api.post(
      ApiEndpoints.pharmChatbot,
      data: {
        'question': question,
        'history': history.map((e) => e.toJson()).toList(),
      },
    );
  }
}
