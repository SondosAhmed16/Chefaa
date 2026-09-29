import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_cubit.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_state.dart';
import 'package:chefaa/features/patient/search/domain/entity/doctor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseClinicsPage extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String doctorSpecialization;
  final double doctorRating;
  final DoctorEntity? doctor;

  const ChooseClinicsPage({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorRating,
    required this.doctor,
  });

  @override
  State<ChooseClinicsPage> createState() => _ChooseClinicsPageState();
}

class _ChooseClinicsPageState extends State<ChooseClinicsPage> {
  @override
  void initState() {
    super.initState();
final cubit = context.read<BookCubit>();
  
  if (cubit.clinics.isEmpty || cubit.selectedDoctor?.id != widget.doctorId) {
    cubit.getDoctorClinics(doctorId: widget.doctorId);
  }  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          (widget.doctor?.profilePicture != null &&
                              widget.doctor!.profilePicture!.isNotEmpty &&
                              widget.doctor!.profilePicture!.startsWith('http'))
                          ? NetworkImage(widget.doctor!.profilePicture!)
                          : const AssetImage('assets/images/doctor.png')
                                as ImageProvider,
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.doctorName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.doctorSpecialization,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.doctor?.rating ?? widget.doctorRating}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Choose Clinic ",
              style: getBoldStyle(color: ColorManager.black, fontSize: 22),
            ),
            const SizedBox(height: 12),

            BlocBuilder<BookCubit, BookState>(
              builder: (context, state) {
                final cubit = BookCubit.get(context);

                if (state is ClinicsLoadingState) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is ClinicsErrorState) {
                  return Center(
                    child: Text(
                      state.error,
                      style: getBoldStyle(
                        color: ColorManager.error,
                        fontSize: 20,
                      ),
                    ),
                  );
                }

                if (cubit.clinics.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text('No Clinics Avilabel Now'),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cubit.clinics.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final clinic = cubit.clinics[index];
                    final isSelected = cubit.selectedClinic?.id == clinic.id;

                    return Card(
                      color: isSelected
                          ? ColorManager.sky200
                          : ColorManager.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isSelected
                              ? ColorManager.blue100
                              : ColorManager.gray,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        title: Text(
                          clinic.name!,
                          style: getSemiBoldStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          clinic.address!,
                          style: getRegularStyle(
                            color: ColorManager.gray,
                            fontSize: 14,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: ColorManager.primary,
                          size: 16,
                        ),
                        onTap: () {
                          cubit.selectClinic(clinic);
                          cubit.nextStep();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
