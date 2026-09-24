import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/notification/presentation/cubit/notification_cubit.dart';
import 'package:chefaa/features/patient/notification/presentation/cubit/notification_state.dart';
import 'package:chefaa/features/patient/notification/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                  "My Notifications",
                  style: getBoldStyle(color: ColorManager.white, fontSize: 18),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  );
                } else if (state is NotificationErrorState) {
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
                        state.errorMessage,
                        style: getBoldStyle(
                          color: ColorManager.error,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                } else if (state is NotificationSuccessState) {
                  if (state.notification.isEmpty) {
                    return Center(
                      child: Container(
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
                    itemCount: state.notification.length,
                    padding: const EdgeInsets.only(top: 12, bottom: 24),
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        icon: Icons.notifications_outlined,
                        title: state.notification[index].title ?? "",
                        body: state.notification[index].message ?? "",
                        isRead: state.notification[index].isRead ?? false,
                        type: state.notification[index].type ?? "",
                        onTap: () {
                          context.read<NotificationCubit>().markAsRead(
                            state.notification[index],
                          );
                        },
                        dateTime:
                            state.notification[index].createdAt ??
                            DateTime.now(),
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
