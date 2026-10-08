import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';

sealed class ChatbotPatientState {
  final List<ConversationHistory> conversationHistory;

  ChatbotPatientState(this.conversationHistory);
}

class ChatbotPatientInitial extends ChatbotPatientState {
  ChatbotPatientInitial(super.conversationHistory);
}

class ChatbotPatientLoading extends ChatbotPatientState {
  ChatbotPatientLoading(super.conversationHistory);
}

class ChatbotPatientSuccess extends ChatbotPatientState {
  ChatbotPatientSuccess(super.conversationHistory);
}

class ChatbotPatientError extends ChatbotPatientState {
  final ErrorModel error;

  ChatbotPatientError(super.conversationHistory, this.error);
}
