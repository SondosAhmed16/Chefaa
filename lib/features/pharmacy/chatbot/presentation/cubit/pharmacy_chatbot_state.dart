import 'package:chefaa/core/error%20handle/error_model.dart';

sealed class PharmacyChatbotState {
  final List<Map<String, dynamic>> messages;

  PharmacyChatbotState(this.messages);
}

class PharmacyChatbotInitial extends PharmacyChatbotState {
  PharmacyChatbotInitial(super.messages);
}

class ChatbotLoading extends PharmacyChatbotState {
  ChatbotLoading(super.messages);
}

class ChatbotSuccess extends PharmacyChatbotState {
  ChatbotSuccess(super.messages);
}

class ChatbotError extends PharmacyChatbotState {
  final ErrorModel errorMessage;

  ChatbotError(super.messages, this.errorMessage);
}
