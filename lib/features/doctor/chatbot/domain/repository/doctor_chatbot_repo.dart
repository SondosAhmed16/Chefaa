import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/doctor_chatbot_model.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorChatbotRepo {
  Future<Either<ErrorModel, DoctorChatbotModel>> doctorChatbot({
    required String message,
    required List<ChatHistory> history,
  });
}
