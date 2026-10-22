import 'package:chefaa/core/error%20handle/error_model.dart';

sealed class DoctorChatbotState {
  final List<Map<String, dynamic>> messages;

  DoctorChatbotState(this.messages);
}

class DoctorChatbotInitial extends DoctorChatbotState {
  DoctorChatbotInitial(super.messages);
}

class DoctorChatbotLoading extends DoctorChatbotState {
  DoctorChatbotLoading(super.messages);
}

class DoctorChatbotSuccess extends DoctorChatbotState {
  DoctorChatbotSuccess(super.messages);
}

class DoctorChatbotError extends DoctorChatbotState {
  final ErrorModel error;

  DoctorChatbotError(super.messages, this.error);
}
