import 'package:chefaa/features/doctor/chatbot/data/model/chat_history.dart';
import 'package:chefaa/features/pharmacy/chatbot/domain/repository/chatbot_pharmacy_repo.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/cubit/pharmacy_chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyChatbotCubit extends Cubit<PharmacyChatbotState> {
  final ChatbotPharmacyRepo repo;

  final List<Map<String, dynamic>> _messages = [
    {"message": "Hello 👋\nHow can I help you today?", "isBot": true},
  ];

  List<Map<String, dynamic>> get messages => List.unmodifiable(_messages);

  PharmacyChatbotCubit({required this.repo})
    : super(
        PharmacyChatbotInitial([
          {
            "message":
                "Hello 👋\nHow can I help you manage your pharmacy today?",
            "isBot": true,
          },
        ]),
      );

  static PharmacyChatbotCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> sendQuestion(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = text.trim();

    final nextMessages = List<Map<String, dynamic>>.from(_messages)
      ..add({"message": userMessage, "isBot": false})
      ..add({"isBot": true, "isLoading": true});

    _messages
      ..clear()
      ..addAll(nextMessages);

    if (!isClosed) emit(ChatbotLoading(List.unmodifiable(_messages)));

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

    final result = await repo.pharmChatbot(
      question: userMessage,
      history: history,
    );

    _messages.removeWhere((e) => e["isLoading"] == true);

    result.fold(
      (error) {
        _messages.add({"message": error.message, "isBot": true});
        if (!isClosed) {
          emit(ChatbotError(List.unmodifiable(_messages), error));
        }
      },
      (response) {
        final botAnswer = response.data?.answer;
        _messages.add({"message": botAnswer, "isBot": true});
        if (!isClosed) {
          emit(ChatbotSuccess(List.unmodifiable(_messages)));
        }
      },
    );
  }
}
