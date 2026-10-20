import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/doctor/chatbot/data/datasource/doctor_chatbot_datasource.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/doctor_chatbot_model.dart';
import 'package:chefaa/features/doctor/chatbot/domain/repository/doctor_chatbot_repo.dart';
import 'package:dartz/dartz.dart';

class DoctorChatbotRepoImp implements DoctorChatbotRepo {
  final DoctorChatbotDatasource datasource;

  DoctorChatbotRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, DoctorChatbotModel>> doctorChatbot({
    required String message,
    required List<ChatHistory> history,
  }) async {
    try {
      final response = await datasource.doctorChatbot(
        message: message,
        history: history,
      );
      final model = DoctorChatbotModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
