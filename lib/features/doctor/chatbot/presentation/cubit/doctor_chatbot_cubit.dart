import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';
import 'package:chefaa/features/doctor/chatbot/domain/usecase/doctor_chatbot_usecase.dart';
import 'package:chefaa/features/doctor/chatbot/presentation/cubit/doctor_chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorChatbotCubit extends Cubit<DoctorChatbotState> {
  final DoctorChatbotUsecase doctorChatbotUsecase;

  final List<Map<String, dynamic>> _messages = [
    {"message": "Hello 👋\nHow can I help you today?", "isBot": true},
  ];

  List<Map<String, dynamic>> get messages => List.unmodifiable(_messages);

  DoctorChatbotCubit({required this.doctorChatbotUsecase})
    : super(
        DoctorChatbotInitial([
          {"message": "Hello 👋\nHow can I help you today?", "isBot": true},
        ]),
      );

  static DoctorChatbotCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> doctorChatbot(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = text.trim();
    final nextMessages = List<Map<String, dynamic>>.from(_messages)
      ..add({"message": userMessage, "isBot": false})
      ..add({"isBot": true, "isLoading": true});

    _messages
      ..clear()
      ..addAll(nextMessages);

    if (!isClosed) emit(DoctorChatbotLoading(List.unmodifiable(_messages)));

    final history = _messages
        .where((m) => m["isLoading"] != true)
        .take(_messages.length - 2)
        .map(
          (m) => ChatHistory(
            role: m["isBot"] == true ? "assistant" : "user",
            content: m["message"] ?? '',
          ),
        )
        .toList();

    final response = await doctorChatbotUsecase.call(
      message: userMessage,
      history: history,
    );

    _messages.removeWhere((e) => e["isLoading"] == true);

    response.fold(
      (error) {
        _messages.add({"message": error.message, "isBot": true});
        debugPrint('DocChatbotCubit error message="${error.message}"');
        if (!isClosed) {
          emit(DoctorChatbotError(List.unmodifiable(_messages), error));
        }
      },
      (doctorChatbotModel) {
        final reply = doctorChatbotModel.reply ?? '';
        _messages.add({"message": reply, "isBot": true});
        debugPrint('DocChatbotCubit success reply="$reply"');
        if (!isClosed) {
          emit(DoctorChatbotSuccess(List.unmodifiable(_messages)));
        }
      },
    );
  }
}
