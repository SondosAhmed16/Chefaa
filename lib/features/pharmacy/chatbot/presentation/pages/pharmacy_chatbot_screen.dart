import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/cubit/pharmacy_chatbot_cubit.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/cubit/pharmacy_chatbot_state.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/widget/pharmacy_bot_header_widget.dart';
import 'package:chefaa/features/doctor/chatbot/presentation/widgets/chat_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyChatbotScreen extends StatefulWidget {
  const PharmacyChatbotScreen({super.key});

  @override
  State<PharmacyChatbotScreen> createState() => _PharmacyChatbotScreenState();
}

class _PharmacyChatbotScreenState extends State<PharmacyChatbotScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorManager.lightBlue),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/bot.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: ColorManager.lightGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chefaa Assistant',
                  style: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 3,
                      backgroundColor: ColorManager.lightGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Always here to help',
                      style: getRegularStyle(
                        color: ColorManager.darkGray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: ColorManager.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<PharmacyChatbotCubit, PharmacyChatbotState>(
              listener: (context, state) {
                _scrollToBottom();
                if (state is ChatbotError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage.message),
                      backgroundColor: ColorManager.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final messages = state.messages;

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: messages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const PharmacyBotHeaderWidget();
                    }
                    final messageItem = messages[index - 1];

                    if (messageItem["isLoading"] == true) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    }

                    return ChatMessageBubble(
                      message: messageItem["message"] ?? '',
                      isBot: messageItem["isBot"] ?? false,
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(color: ColorManager.white),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.attach_file,
                      color: ColorManager.gray,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: ColorManager.input),
                      ),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Ask Chefaa Assistant...',
                          hintStyle: getRegularStyle(
                            color: ColorManager.gray,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      final text = _textController.text;
                      if (text.trim().isNotEmpty) {
                        context.read<PharmacyChatbotCubit>().sendQuestion(text);
                        _textController.clear();
                      }
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: ColorManager.primary,
                      child: Icon(
                        Icons.send_rounded,
                        color: ColorManager.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
