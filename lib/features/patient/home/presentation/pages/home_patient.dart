import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/services/share_services.dart';
import 'package:chefaa/core/widgets/custom_bar_layout.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_state.dart';
import 'package:chefaa/features/patient/appointment/presentation/pages/reschedual_screen.dart';
import 'package:chefaa/features/patient/appointment/presentation/widget/appointment_card.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_cubit.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_state.dart';
import 'package:chefaa/features/patient/home/presentation/widget/quick_actions.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_cubit.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_state.dart';
import 'package:chefaa/features/patient/medication/presentation/widget/medicine_card.dart';
import 'package:chefaa/features/patient/notification/presentation/cubit/notification_cubit.dart';
import 'package:chefaa/features/patient/notification/presentation/cubit/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePatient extends StatefulWidget {
  const HomePatient({super.key});

  @override
  State<HomePatient> createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final name = await ShareServices.getString('userName');
      print(">>> CHECK STORED NAME: '$name'");

      context.read<UsersCubit>().loadUserFromPrefs();
      context.read<AppointmentCubit>().fetchAppointments();
    });

    context.read<UsersCubit>().loadUserFromPrefs();
    context.read<NotificationCubit>().getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(175),
        child: Builder(
          builder: (context) {
            final userName = context.select<UsersCubit, String>((cubit) {
              final state = cubit.state;
              if (state is UserLoaded) return state.user.name;
              if (state is UsersLoading) return "...";
              return "Patient";
            });

            final hasUnread = context.select<NotificationCubit, bool>((cubit) {
              final state = cubit.state;
              if (state is NotificationSuccessState) {
                return state.notification.any((e) => e.isRead != true);
              }
              return false;
            });

            return CustomAppBarLayout(
              title1: "Hello",
              title2: userName,
              hasUnreadNotifications: hasUnread,
              onPressed: () {
                Navigator.pushNamed(context, Routes.getPatientnotification);
              },
            );
          },
        ),
      ),
      body: BlocListener<MedicationCubit, MedicationState>(
        listenWhen: (previous, current) =>
            current is MedicationConfirmSuccessState ||
            current is MedicationListErrorState,
        listener: (context, state) {
          if (state is MedicationConfirmSuccessState) {
            context.read<MedicationCubit>().getMedicationList();
          }

          if (state is MedicationListErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: ColorManager.error,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Today's Medication",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        BlocBuilder<MedicationCubit, MedicationState>(
                          buildWhen: (previous, current) =>
                              current is MedicationListLoadingState ||
                              current is MedicationListSuccessState ||
                              current is MedicationListErrorState,
                          builder: (context, state) {
                            final medications =
                                state is MedicationListSuccessState
                                ? (state.medications.medications ?? [])
                                : <dynamic>[];

                            if (medications.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return TextButton(
                              onPressed: () => {
                                Navigator.pushNamed(context, Routes.myMed),
                              },

                              child: Row(
                                children: [
                                  Text(
                                    "Manage",
                                    style:
                                        getMediumStyle(
                                          color: ColorManager.primary,
                                          fontSize: 16,
                                        ).copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationColor: ColorManager.primary,
                                          decorationThickness: 2,
                                        ),
                                  ),
                                  SvgPicture.asset("assets/icons/drug.svg"),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<MedicationCubit, MedicationState>(
                      buildWhen: (previous, current) =>
                          current is MedicationListLoadingState ||
                          current is MedicationListSuccessState ||
                          current is MedicationListErrorState,
                      builder: (context, state) {
                        if (state is MedicationListLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                            ),
                          );
                        }

                        if (state is MedicationListErrorState) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.lightGray,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: ColorManager.error,
                                  size: 40,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  state.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: getMediumStyle(
                                    color: ColorManager.gray,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<MedicationCubit>()
                                        .getMedicationList();
                                  },
                                  child: const Text("Retry"),
                                ),
                              ],
                            ),
                          );
                        }

                        if (state is MedicationListSuccessState) {
                          final medications =
                              state.medications.medications ?? [];

                          if (medications.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                color: ColorManager.lightGray,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.medication_outlined,
                                    size: 30.sp,
                                    color: ColorManager.primary.withAlpha(80),
                                  ),
                                  12.verticalSpace,
                                  Text(
                                    "No Medications Yet",
                                    style: getBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  5.verticalSpace,
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40.w,
                                    ),
                                    child: Text(
                                      "Add your medications to track them daily",
                                      style: getMediumStyle(
                                        color: ColorManager.gray,
                                        fontSize: 12.sp,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  5.verticalSpace,
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.myMed,
                                      );
                                    },
                                    child: Text(
                                      "Add Medicine",
                                      style: getMediumStyle(
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return MedicineCard(
                            medications: medications,
                            onPressed: (med) {
                              context.read<MedicationCubit>().ConfirmMedication(
                                medicationId: med.id ?? '',
                              );
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                    45.verticalSpace,

                    BlocBuilder<AppointmentCubit, AppointmentState>(
                      buildWhen: (previous, current) =>
                          current is AppointmentLoading ||
                          current is AppointmentSuccess ||
                          current is AppointmentError,
                      builder: (context, state) {
                        if (state is AppointmentLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CircularProgressIndicator(
                                color: ColorManager.primary,
                              ),
                            ),
                          );
                        }

                        if (state is AppointmentSuccess) {
                          final appointments = state.appointments;

                          if (appointments.isEmpty) {
                            return Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 24.h),
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                color: ColorManager.lightGray,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: ColorManager.primary,
                                    size: 30.sp,
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "No Upcoming Appointments",
                                          style: getBoldStyle(
                                            color: ColorManager.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          "Book doctor appointments easily",
                                          style: getMediumStyle(
                                            color: ColorManager.gray,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.getPatientAppo,
                                      );
                                    },
                                    child: Text(
                                      "Book Now",
                                      style: getBoldStyle(
                                        color: ColorManager.primary,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          final upcomingAppointment = appointments.last;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Upcoming Appointment",
                                    style: getBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.getPatientAppo,
                                      );
                                    },
                                    child: Text(
                                      "View All",
                                      style:
                                          getMediumStyle(
                                            color: ColorManager.primary,
                                            fontSize: 16,
                                          ).copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                ColorManager.primary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              AppointmentCard(
                                appointment: upcomingAppointment,
                                onDecline: () {},
                                onReschedule: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<AppointmentCubit>(),
                                        child: ReschedualScreen(
                                          appointment: upcomingAppointment,
                                          clinic: upcomingAppointment.clinic!,
                                        ),
                                      ),
                                    ),
                                  ).then((updated) {
                                    if (updated == true) {
                                      context
                                          .read<AppointmentCubit>()
                                          .fetchAppointments();
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: QuickActions(
                        title: "Emergency",
                        image: "assets/svg_images/phone.svg",
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: QuickActions(
                        title: "Appointment",
                        image: "assets/svg_images/appointment.svg",
                        onTap: () {
                          Navigator.pushNamed(context, Routes.getPatientAppo);
                        },
                      ),
                    ),
                    Expanded(
                      child: QuickActions(
                        title: "Order Pharmacy",
                        image: "assets/svg_images/order_pharmacy.svg",
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: QuickActions(
                        title: "Find Lab",
                        image: "assets/svg_images/find_lab.svg",
                        onTap: () {},
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
