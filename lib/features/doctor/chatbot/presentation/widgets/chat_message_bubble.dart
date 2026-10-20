import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final bool isBot;
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isBot,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isBot
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isBot) ...[
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
                color: isBot ? ColorManager.primary : ColorManager.lightBlue100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isBot ? 16 : 4),
                  bottomRight: Radius.circular(isBot ? 4 : 16),
                ),
              ),
              child: Text(
                message,
                style: isBot
                    ? getRegularStyle(color: ColorManager.white, fontSize: 14)
                    : getMediumStyle(color: ColorManager.black, fontSize: 14),
              ),
            ),
          ),
          if (isBot) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
