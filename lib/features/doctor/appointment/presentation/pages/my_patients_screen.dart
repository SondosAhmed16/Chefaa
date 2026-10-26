import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/doctor/appointment/presentation/widget/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_appo_state.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_repo_cubit.dart';

class MyPatientsScreen extends StatelessWidget {
  const MyPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                'My Patients',
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Tabs (Upcoming / Completed)
          BlocBuilder<DoctorRepoCubit, DoctorAppoState>(
            buildWhen: (previous, current) =>
                current is DoctorAppoSuccess || current is DoctorAppoLoading,
            builder: (context, state) {
              int selectedIndex = 0;
              if (state is DoctorAppoSuccess) {
                selectedIndex = state.selectedIndex;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Upcoming Tab
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 0
                              ? ColorManager.primary
                              : ColorManager.input,
                          foregroundColor: selectedIndex == 0
                              ? ColorManager.white
                              : ColorManager.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          context.read<DoctorRepoCubit>().changeTab(0);
                        },
                        child: Text(
                          'Upcoming',
                          style: getMediumStyle(
                            color: selectedIndex == 0
                                ? ColorManager.white
                                : ColorManager.black,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Completed Tab
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedIndex == 1
                              ? ColorManager.primary
                              : ColorManager.input,
                          foregroundColor: selectedIndex == 1
                              ? ColorManager.white
                              : ColorManager.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          context.read<DoctorRepoCubit>().changeTab(1);
                        },
                        child: Text(
                          'Completed',
                          style: getMediumStyle(
                            color: selectedIndex == 1
                                ? ColorManager.white
                                : ColorManager.black,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 15),

          // Patients List
          Expanded(
            child: BlocBuilder<DoctorRepoCubit, DoctorAppoState>(
              builder: (context, state) {
                if (state is DoctorAppoLoading ||
                    (state is DoctorAppoSuccess && state.isUpcomingLoading)) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  );
                } else if (state is DoctorAppoError) {
                  return Center(
                    child: Text(
                      state.error,
                      style: getMediumStyle(
                        color: ColorManager.error,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  );
                } else if (state is DoctorAppoSuccess) {
                  final patientsList = state.currentList;

                  if (patientsList.isEmpty) {
                    return Center(
                      child: Text(
                        'No patients found',
                        style: getRegularStyle(
                          color: ColorManager.gray,
                          fontSize: FontSize.s16,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: patientsList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final appointment = patientsList[index];
                      return PatientCard(appointment: appointment);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
