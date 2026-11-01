import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/datasource/pharmacy_chatbot_datasource.dart';
import 'package:chefaa/features/pharmacy/chatbot/data/model/pharmacy_chatbot/pharmacy_chatbot.dart';
import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';
import 'package:chefaa/features/pharmacy/chatbot/domain/repository/chatbot_pharmacy_repo.dart';
import 'package:dartz/dartz.dart';

class PharmacyChatbotRepoImp implements ChatbotPharmacyRepo {
  final PharmacyChatbotDatasource datasource;

  PharmacyChatbotRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, PharmacyChatbot>> pharmChatbot({
    required String question,
    required List<ChatHistory> history,
  }) async {
    try {
      final response = await datasource.pharmChatbot(
        question: question,
        history: history,
      );
      final model = PharmacyChatbot.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
