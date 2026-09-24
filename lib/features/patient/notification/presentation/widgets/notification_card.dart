import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final DateTime dateTime;
  final String type;
  final bool isRead;
  final VoidCallback? onTap;
  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.dateTime,
    required this.type,
    required this.isRead,
    this.onTap,
  });

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} h ago";
    } else if (diff.inDays == 1) {
      return "Yesterday";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    }

    return DateFormat("dd MMM • hh:mm a").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorManager.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRead
                ? ColorManager.white
                : ColorManager.primary.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isRead
                  ? ColorManager.input
                  : ColorManager.primary.withValues(alpha: .35),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withValues(alpha: .04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: .12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: ColorManager.primary, size: 26),
              ),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        if (!isRead)
                          Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: ColorManager.error,
                              shape: BoxShape.circle,
                            ),
                          ),

                        Text(
                          _formatTime(dateTime),
                          style: getRegularStyle(
                            color: ColorManager.gray,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      type.toUpperCase(),
                      style: getSemiBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                        color: ColorManager.gray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
