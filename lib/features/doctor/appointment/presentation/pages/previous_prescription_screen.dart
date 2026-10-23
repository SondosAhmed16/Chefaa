import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/doctor/appointment/data/model/previous_prescription_model/previous_prescription_model.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_appo_state.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_repo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreviousPrescriptionScreen extends StatefulWidget {
  final String appointmentId;

  const PreviousPrescriptionScreen({super.key, required this.appointmentId});

  @override
  State<PreviousPrescriptionScreen> createState() => _PreviousPrescriptionScreenState();
}

class _PreviousPrescriptionScreenState extends State<PreviousPrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _diagnosisController;
  late final TextEditingController _labTestsController;
  late final TextEditingController _imagingController;
  late final TextEditingController _nextVisitController;
  late final TextEditingController _notesController;

  final List<Map<String, TextEditingController>> _medicinesList = [];

  @override
  void initState() {
    super.initState();
    _diagnosisController = TextEditingController();
    _labTestsController = TextEditingController();
    _imagingController = TextEditingController();
    _nextVisitController = TextEditingController();
    _notesController = TextEditingController();
  }

  void _initializeData(PreviousPrescriptionModel model) {
    final data = model.data;
    if (data == null) return;

    _diagnosisController.text = data.diagnosis ?? '';
    _labTestsController.text = data.labTests?.join(', ') ?? '';
    _imagingController.text = data.imaging?.join(', ') ?? '';
    _nextVisitController.text = data.nextVisit ?? '';
    _notesController.text = data.notes ?? '';

    _medicinesList.clear();
    if (data.medicines != null && data.medicines!.isNotEmpty) {
      for (var med in data.medicines!) {
        _medicinesList.add({
          'name': TextEditingController(text: med.name ?? ''),
          'dosage': TextEditingController(text: med.dosage ?? ''),
          'frequency': TextEditingController(text: med.frequency ?? ''),
          'duration': TextEditingController(text: med.duration ?? ''),
          'instructions': TextEditingController(text: med.instructions ?? ''),
        });
      }
    }
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _labTestsController.dispose();
    _imagingController.dispose();
    _nextVisitController.dispose();
    _notesController.dispose();
    for (var med in _medicinesList) {
      med.values.forEach((c) => c.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        title: Text(
          'Previous Prescription',
          style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
        ),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
      ),
      body: BlocBuilder<DoctorRepoCubit, DoctorAppoState>(
        builder: (context, state) {
          if (state is GetPreviousPrescriptionLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is GetPreviousPrescriptionSuccess) {
            if (_diagnosisController.text.isEmpty &&
                state.previousPrescriptionModel.data != null) {
              _initializeData(state.previousPrescriptionModel);
            }
          } else if (state is GetPreviousPrescriptionError) {
            return Center(
              child: Text(
                state.error.message,
                style: getMediumStyle(color: ColorManager.error, fontSize: FontSize.s16),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Diagnosis Field (Read-only)
                  CustomTextField(
                    controller: _diagnosisController,
                    text: 'Diagnosis',
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Medicines',
                    style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
                  ),
                  const SizedBox(height: 8),

                  ..._medicinesList.asMap().entries.map((entry) {
                    int index = entry.key;
                    var med = entry.value;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 2,
                      color: ColorManager.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Medicine #${index + 1}',
                              style: getBoldStyle(
                                color: ColorManager.primary,
                                fontSize: FontSize.s14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['name']!,
                              text: 'Medicine Name',
                              isReadOnly: true,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['dosage']!,
                              text: 'Dosage',
                              isReadOnly: true,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['frequency']!,
                              text: 'Frequency',
                              isReadOnly: true,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['duration']!,
                              text: 'Duration',
                              isReadOnly: true,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['instructions']!,
                              text: 'Instructions',
                              isReadOnly: true,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _labTestsController,
                    text: 'Lab Tests',
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _imagingController,
                    text: 'Imaging',
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _nextVisitController,
                    text: 'Next Visit',
                    isReadOnly: true,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _notesController,
                    text: 'Notes',
                    isReadOnly: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}