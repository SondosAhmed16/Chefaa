import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/doctor_chatbot_model.dart';
import 'package:chefaa/features/doctor/chatbot/domain/repository/doctor_chatbot_repo.dart';
import 'package:dartz/dartz.dart';

class DoctorChatbotUsecase {
  final DoctorChatbotRepo repo;

  DoctorChatbotUsecase({required this.repo});

  Future<Either<ErrorModel, DoctorChatbotModel>> call({
    required String message,
    required List<ChatHistory> history,
  }) async {
    return await repo.doctorChatbot(message: message, history: history);
  }
}
