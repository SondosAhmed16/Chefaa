import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/chatbot/data/model/conversation_history.dart';
import 'package:flutter/widgets.dart';

class ChatMessageBubble extends StatelessWidget {
  final ConversationHistory message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorManager.lightBlue),
              ),
              child: ClipOval(
                child: Image.asset('assets/images/bot.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUser
                    ? ColorManager.primary
                    : ColorManager.lightBlue100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
              ),
              child: Text(
                message.content ?? '',
                style: isUser
                    ? getRegularStyle(color: ColorManager.white, fontSize: 14)
                    : getMediumStyle(color: ColorManager.black, fontSize: 14),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
