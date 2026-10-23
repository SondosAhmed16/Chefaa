import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_repo_cubit.dart';
import 'package:chefaa/features/doctor/appointment/presentation/pages/patient_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/doctor_appointment_model/datum.dart';

class PatientCard extends StatelessWidget {
  final Datum appointment;

  const PatientCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final doctorRepoCubit = context.read<DoctorRepoCubit>();

    final patientName = appointment.patient?.userId?.name ?? 'Unknown Patient';
    final formattedDate = appointment.date != null
        ? "${appointment.date!.day.toString().padLeft(2, '0')}/${appointment.date!.month.toString().padLeft(2, '0')}/${appointment.date!.year}"
        : '';
    final isFollowingUp =
        appointment.prescription?['nextVisit']?.isEmpty ?? false;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: doctorRepoCubit,
              child: PatientDetailsScreen(appointment: appointment),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorManager.gray.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  patientName,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                  ),
                ),
                Text(
                  formattedDate,
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: FontSize.s14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.amber100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isFollowingUp ? 'Following Up' : 'Not Following Up',
                    style: getMediumStyle(
                      color: ColorManager.amber600,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.green100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    appointment.status ?? 'completed',
                    style: getMediumStyle(
                      color: ColorManager.green600,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
