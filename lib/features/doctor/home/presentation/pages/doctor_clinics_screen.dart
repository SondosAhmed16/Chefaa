import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_cubit.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_state.dart';
import 'package:chefaa/features/doctor/home/presentation/widget/clinic_card.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_cubit.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorClinicsScreen extends StatefulWidget {
  const DoctorClinicsScreen({super.key});

  @override
  State<DoctorClinicsScreen> createState() => _DoctorClinicsScreenState();
}

class _DoctorClinicsScreenState extends State<DoctorClinicsScreen> {
  @override
  void initState() {
    super.initState();
    final user = context.read<UsersCubit>().state;
    if (user is UserLoaded) {
      context.read<DoctorHomeCubit>().getMyClinics(doctorId: user.user.id);
    }
  }

  void _refresh() {
    if (!mounted) return;
    final userState = context.read<UsersCubit>().state;
    if (userState is UserLoaded) {
      context.read<DoctorHomeCubit>().getMyClinics(doctorId: userState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UsersCubit, UsersState>(
          listenWhen: (previous, current) => current is UserLoaded,
          listener: (context, state) {
            if (state is UserLoaded) {
              context.read<DoctorHomeCubit>().getMyClinics(
                doctorId: state.user.id,
              );
            }
          },
        ),
        BlocListener<DoctorHomeCubit, DoctorHomeState>(
          listener: (context, state) {
            if (state is DeleteClinicSuccess ||
                state is UpdateClinicSuccess ||
                state is AddClinicSuccess) {
              _refresh();
            }
          },
        ),
      ],
      child: Scaffold(
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
              decoration: const BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Doctor ${state.user.name}",
                          style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "My Clinics",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 20,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final userState = context
                                  .read<UsersCubit>()
                                  .state;
                              if (userState is UserLoaded) {
                                final isAdded = await Navigator.pushNamed(
                                  context,
                                  Routes.addClinic,
                                  arguments: userState.user.id,
                                );

                                if (isAdded == true) {
                                  _refresh();
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 18,
                              color: ColorManager.white,
                            ),
                            label: Text(
                              "Add Clinic",
                              style: getMediumStyle(
                                color: ColorManager.white,
                                fontSize: 13,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Expanded(
                      child: BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
                        builder: (context, state) {
                          if (state is DoctorClinicsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.primary,
                              ),
                            );
                          } else if (state is DoctorClinicsError) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.error,
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.error.message,
                                      style: getBoldStyle(
                                        color: ColorManager.error,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton(
                                      onPressed: () {
                                        _refresh();
                                      },
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (state is DoctorClinicsSuccess) {
                            final clinics = state.clinics!;
                            if (clinics.isEmpty) {
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
                                    "No Clinics yet",
                                    style: getBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return ListView.separated(
                              itemCount: clinics.length,
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 24,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return ClinicCard(
                                  clinic: clinics[index],
                                  onPressed: () async {
                                    final isUpdated = await Navigator.pushNamed(
                                      context,
                                      Routes.doctorClinic,
                                      arguments: clinics[index].id,
                                    );

                                    if (isUpdated == true) {
                                      _refresh();
                                    }
                                  },
                                );
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
