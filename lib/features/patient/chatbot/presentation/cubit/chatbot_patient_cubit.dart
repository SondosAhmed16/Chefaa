import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';
import 'package:chefaa/features/patient/chatbot/domain/usecase/chatbot_patient_usecase.dart';
import 'package:chefaa/features/patient/chatbot/presentation/cubit/chatbot_patient_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatbotPatientCubit extends Cubit<ChatbotPatientState> {
  final ChatbotPatientUsecase usecase;

  ChatbotPatientCubit({required this.usecase})
      : super(
          ChatbotPatientInitial([
            ConversationHistory(
              role: 'assistant',
              content:
                  'Welcome! How can I help you today with your medications or health condition?',
            ),
          ]),
        );

  static ChatbotPatientCubit get(BuildContext context) =>
      BlocProvider.of<ChatbotPatientCubit>(context);

  Future<void> chatbotPatient(String text) async {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) return;

    final previousHistory = state.conversationHistory;
    final updatedHistory = List<ConversationHistory>.from(previousHistory)
      ..add(ConversationHistory(role: 'user', content: trimmedText));

    if (!isClosed) emit(ChatbotPatientLoading(updatedHistory));

    try {
      final result = await usecase.call(
        message: trimmedText,
        conversationHistory: previousHistory,
      );

      result.fold(
        (errorModel) {
          if (!isClosed) {
            emit(ChatbotPatientError(previousHistory, errorModel));
          }
        },
        (chatbotModel) {
          final newHistory =
              chatbotModel.data?.conversationHistory ?? updatedHistory;
          if (!isClosed) {
            emit(ChatbotPatientSuccess(newHistory));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(
          ChatbotPatientError(
            previousHistory,
            ErrorModel(message: e.toString()),
          ),
        );
      }
    }
  }
}