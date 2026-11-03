import 'dart:io';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/features/facility/dashboard/data/model/timeout_patient.dart';
import 'package:chefaa/features/facility/dashboard/presentation/cubit/lab_dashboard_cubit.dart';
import 'package:chefaa/features/facility/dashboard/presentation/cubit/lab_dashboard_state.dart';
import 'package:chefaa/features/facility/requests/presentation/cubit/requests_cubit.dart';
import 'package:chefaa/features/facility/requests/presentation/cubit/requests_state.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadResultScreen extends StatefulWidget {
  const UploadResultScreen({super.key});

  @override
  State<UploadResultScreen> createState() => _UploadResultScreenState();
}

class _UploadResultScreenState extends State<UploadResultScreen> {
  TimeoutPatient? selectedTimeoutPatient;
  File? selectedFile;

  @override
  void initState() {
    super.initState();
    context.read<LabDashboardCubit>().getLabDashboard();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(
          'Upload Result',
          style: getBoldStyle(color: ColorManager.black, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.black),
      ),
      body: BlocConsumer<RequestsCubit, RequestsState>(
        listener: (context, state) {
          if (state is UploadResultSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Result uploaded successfully'),
                backgroundColor: ColorManager.lightGreen,
              ),
            );
            Navigator.pop(context);
          } else if (state is UploadResultError) {
            showDialog(
              context: context,
              builder: (context) => CustomDialog(
                title: "Failed",
                message: state.error.message,
                type: DialogType.fail,
              ),
            );
          }
        },
        builder: (context, requestsState) {
          final isLoading = requestsState is UploadResultLoading;

          return BlocBuilder<LabDashboardCubit, LabDashboardState>(
            builder: (context, dashboardState) {
              List<TimeoutPatient> timeoutList = [];
              if (dashboardState is LabDashboardSuccess) {
                timeoutList =
                    dashboardState.labDashboard.stats?.timeoutPatients ?? [];
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorManager.input,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: ColorManager.gray),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Timeout Patient',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorManager.gray),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<TimeoutPatient>(
                              isExpanded: true,
                              hint: Text(
                                'Choose patient from timeout list',
                                style: getRegularStyle(
                                  color: ColorManager.gray,
                                  fontSize: 14,
                                ),
                              ),
                              value: selectedTimeoutPatient,
                              items: timeoutList.map((patient) {
                                return DropdownMenuItem<TimeoutPatient>(
                                  value: patient,
                                  child: Text(
                                    patient.patientName ?? 'Unknown',
                                    style: getMediumStyle(
                                      color: ColorManager.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedTimeoutPatient = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        if (selectedTimeoutPatient != null) ...[
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.primary.withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Patient Details',
                                  style: getBoldStyle(
                                    color: ColorManager.primary,
                                    fontSize: 14,
                                  ),
                                ),
                                const Divider(color: ColorManager.input),
                                const SizedBox(height: 4),
                                Text(
                                  'Name: ${selectedTimeoutPatient!.patientName ?? "N/A"}',
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tests: ${selectedTimeoutPatient!.tests ?? "N/A"}',
                                  style: getRegularStyle(
                                    color: ColorManager.gray600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        Text(
                          'Upload Lab Report',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // زر اختيار الملف
                        GestureDetector(
                          onTap: isLoading ? null : _pickFile,
                          child: DottedBorder(
                            color: ColorManager.primary,
                            strokeWidth: 2,
                            dashPattern: const [6.4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30,
                                horizontal: 16,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorManager.lightGray,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.cloud_upload_outlined,
                                    size: 60,
                                    color: ColorManager.primary,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Choose a File",
                                    style: getBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tap to Select file',
                                    style: getRegularStyle(
                                      color: ColorManager.gray600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Supported: PDF, JPG, PNG • Max size: 10MB',
                                    style: getRegularStyle(
                                      color: ColorManager.gray,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        if (selectedFile != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: ColorManager.gray),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.insert_drive_file,
                                    size: 40,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        selectedFile!.path.split('/').last,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: getMediumStyle(
                                          color: ColorManager.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${(selectedFile!.lengthSync() / 1024).toStringAsFixed(1)} KB',
                                        style: getRegularStyle(
                                          color: ColorManager.gray,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: ColorManager.lightGreen,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),

                        CustemButton(
                          text: "Upload & Send Result",
                          onPressed:
                              (selectedTimeoutPatient == null ||
                                  selectedFile == null ||
                                  isLoading)
                              ? () {}
                              : () {
                                  final Map<String, dynamic> body = {
                                    "requestId":
                                        selectedTimeoutPatient!.requestId ?? "",
                                    "resultFileUrl": selectedFile!.path,
                                  };

                                  context.read<RequestsCubit>().uploadResult(
                                    body: body,
                                  );
                                },
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
