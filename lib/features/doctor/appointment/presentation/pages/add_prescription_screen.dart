import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_repo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_appo_state.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final String appointmentId;

  const AddPrescriptionScreen({super.key, required this.appointmentId});

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
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

    _addMedicineRow();
  }

  void _addMedicineRow({
    String name = '',
    String dosage = '',
    String frequency = '',
    String duration = '',
    String instructions = '',
  }) {
    setState(() {
      _medicinesList.add({
        'name': TextEditingController(text: name),
        'dosage': TextEditingController(text: dosage),
        'frequency': TextEditingController(text: frequency),
        'duration': TextEditingController(text: duration),
        'instructions': TextEditingController(text: instructions),
      });
    });
  }

  void _removeMedicineRow(int index) {
    setState(() {
      _medicinesList[index].values.forEach(
        (controller) => controller.dispose(),
      );
      _medicinesList.removeAt(index);
    });
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _labTestsController.dispose();
    _imagingController.dispose();
    _nextVisitController.dispose();
    _notesController.dispose();
    for (var med in _medicinesList) {
      med.values.forEach((controller) => controller.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        title: Text(
          'Add Prescription',
          style: getBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.s18,
          ),
        ),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
      ),
      body: BlocConsumer<DoctorRepoCubit, DoctorAppoState>(
        listener: (context, state) {
          if (state is AddPrescriptionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.addPrescreptionModel.message ?? 'Added successfully',
                ),
              ),
            );
            Navigator.pop(context);
          } else if (state is AddPrescriptionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message),
                backgroundColor: ColorManager.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddPrescriptionLoading;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                    controller: _diagnosisController,
                    text: 'Diagnosis',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter diagnosis'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicines',
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _addMedicineRow(),
                        icon: const Icon(
                          Icons.add_circle,
                          color: ColorManager.primary,
                          size: 30,
                        ),
                      ),
                    ],
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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Medicine #${index + 1}',
                                  style: getBoldStyle(
                                    color: ColorManager.primary,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                                if (_medicinesList.length > 1)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: ColorManager.error,
                                    ),
                                    onPressed: () => _removeMedicineRow(index),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              controller: med['name']!,
                              text: 'Medicine Name',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['dosage']!,
                              text: 'Dosage (e.g., 1 tablet)',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['frequency']!,
                              text: 'Frequency (e.g., Every 12 hours)',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['duration']!,
                              text: 'Duration (e.g., 3 days)',
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: med['instructions']!,
                              text: 'Instructions (e.g., Take after meals)',
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _labTestsController,
                    text: 'Lab Tests (Comma separated, e.g., CBC, TSH)',
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _imagingController,
                    text: 'Imaging (Comma separated, e.g., MRI, X-Ray)',
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _nextVisitController,
                    text: 'Next Visit (YYYY-MM-DD)',
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(controller: _notesController, text: 'Notes'),
                  const SizedBox(height: 24),

                  CustemButton(
                    text: 'Submit Prescription',
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        List<Map<String, dynamic>> medicinesData =
                            _medicinesList.map((med) {
                              return {
                                'name': med['name']!.text,
                                'dosage': med['dosage']!.text,
                                'frequency': med['frequency']!.text,
                                'duration': med['duration']!.text,
                                'instructions': med['instructions']!.text,
                              };
                            }).toList();

                        List<String> labTestsList =
                            _labTestsController.text.isNotEmpty
                            ? _labTestsController.text
                                  .split(',')
                                  .map((e) => e.trim())
                                  .toList()
                            : [];

                        List<String> imagingList =
                            _imagingController.text.isNotEmpty
                            ? _imagingController.text
                                  .split(',')
                                  .map((e) => e.trim())
                                  .toList()
                            : [];

                        context.read<DoctorRepoCubit>().addPrescription(
                          appointment: widget.appointmentId,
                          diagnosis: _diagnosisController.text,
                          medicines: medicinesData,
                          labTests: labTestsList,
                          imaging: imagingList,
                          nextVisit: _nextVisitController.text,
                          notes: _notesController.text,
                        );
                      }
                    },
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
