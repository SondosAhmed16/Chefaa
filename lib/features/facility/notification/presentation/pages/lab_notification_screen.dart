import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/facility/notification/presentation/cubit/lab_notification_cubit.dart';
import 'package:chefaa/features/facility/notification/presentation/cubit/lab_notification_state.dart';
import 'package:chefaa/features/facility/notification/presentation/widget/lab_notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabNotificationScreen extends StatefulWidget {
  const LabNotificationScreen({super.key});

  @override
  State<LabNotificationScreen> createState() => _LabNotificationScreenState();
}

class _LabNotificationScreenState extends State<LabNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 24,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Text(
                  "Notifications",
                  style: getBoldStyle(color: ColorManager.white, fontSize: 18),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<LabNotificationCubit, LabNotificationState>(
              builder: (context, state) {
                if (state is LabNotificationLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  );
                } else if (state is LabNotificationError) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.error, width: 1),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: ColorManager.gray,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        state.error.message,
                        style: getBoldStyle(
                          color: ColorManager.error,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                } else if (state is LabNotificationSuccess) {
                  final notificationList = state.notification.news ?? [];

                  if (notificationList.isEmpty) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: ColorManager.gray,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Text(
                          "No Notification yet",
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: notificationList.length,
                    padding: const EdgeInsets.all(24),
                    itemBuilder: (context, index) {
                      final item = notificationList[index];
                      return LabNotificationCard(
                        icon: item.type == "timeout_alert"
                            ? Icons.assignment_late_rounded
                            : Icons.fiber_new_rounded,
                        title: item.title ?? "",
                        body: item.message ?? "",
                        dateTime: item.createdAt ?? DateTime.now(),
                        type: item.type ?? "",
                        isRead: item.isRead ?? false,
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
