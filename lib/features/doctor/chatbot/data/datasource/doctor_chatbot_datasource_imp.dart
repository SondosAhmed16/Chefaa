import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/doctor/chatbot/data/datasource/doctor_chatbot_datasource.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';

class DoctorChatbotDatasourceImp implements DoctorChatbotDatasource {
  final ApiConsumer api;

  DoctorChatbotDatasourceImp({required this.api});

  @override
  Future<dynamic> doctorChatbot({
    required String message,
    required List<ChatHistory> history,
  }) async {
    return await api.post(
      ApiEndpoints.DoctorChatbot,
      data: {
        'message': message,
        'history': history.map((e) => e.toJson()).toList(),
      },
    );
  }
}
