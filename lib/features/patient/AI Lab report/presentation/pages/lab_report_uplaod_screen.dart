import 'dart:io';

import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/cubit/ai_report_cubit.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/cubit/ai_report_state.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/pages/lab_report_result_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LabReportUplaodScreen extends StatefulWidget {
  const LabReportUplaodScreen({super.key});

  @override
  State<LabReportUplaodScreen> createState() => _LabReportUplaodScreenState();
}

class _LabReportUplaodScreenState extends State<LabReportUplaodScreen> {
  File? selectedFile;

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
          'AI Lab Report Analysis',
          style: getBoldStyle(color: ColorManager.black, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.white,
        elevation: 0,
      ),
      body: BlocConsumer<AiReportCubit, AiReportState>(
        listener: (context, state) {
          if (state is AiReportSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LabReportResultScreen(data: state.data),
              ),
            );
          } else if (state is AiReportErrorState) {
            showDialog(
              context: context,
              builder: (context) => CustomDialog(
                title: "Failed ",
                message: state.error.message,
                type: DialogType.fail,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AiReportLoadingState;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorManager.input,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: ColorManager.gray),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Lab Report',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: isLoading ? null : _pickFile,

                      child: DottedBorder(
                        color: ColorManager.primary,
                        strokeWidth: 2,
                        dashPattern: [6.4],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(20),
                        child: Container(
                          padding: EdgeInsets.symmetric(
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
                              Image.asset(
                                "assets/images/backup.png",
                                width: 100,
                                height: 100,
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
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorManager.gray),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Image.asset(
                                "assets/images/pdf.png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '${(selectedFile!.lengthSync() / 1024).toStringAsFixed(1)}KB',
                                    style: getRegularStyle(
                                      color: ColorManager.gray,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/icons/Done.svg",
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    CustemButton(
                      text: "Analyze Report",
                      onPressed: (selectedFile == null || isLoading)
                          ? () {}
                          : () {
                              AiReportCubit.get(
                                context,
                              ).analyzeReport(labReport: selectedFile!);
                            },
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
