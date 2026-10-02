import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';
import 'package:chefaa/features/patient/lab%20results/presentation/cubit/lab_result_cubit.dart';
import 'package:chefaa/features/patient/lab%20results/presentation/cubit/lab_result_state.dart';
import 'package:chefaa/features/patient/lab%20results/presentation/widgets/lab_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabResultPage extends StatefulWidget {
  const LabResultPage({super.key});

  @override
  State<LabResultPage> createState() => _LabResultPageState();
}

class _LabResultPageState extends State<LabResultPage> {
  @override
  void initState() {
    super.initState();
    context.read<LabResultCubit>().getLabResult();
  }

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
                  "My Lab Results",
                  style: getBoldStyle(color: ColorManager.white, fontSize: 18),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: BlocBuilder<LabResultCubit, LabResultState>(
              builder: (context, state) {
                if (state is LabResultLooadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  );
                } else if (state is LabResultErrorState) {
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
                        state.error.message,
                        style: getBoldStyle(
                          color: ColorManager.error,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                } else if (state is LabResultSuccessState) {
                  if (state.results.isEmpty) {
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
                          "No Lab Results yet",
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.results.length,
                    padding: const EdgeInsets.only(top: 12, bottom: 24),

                    itemBuilder: (context, index) {
                      final result = state.results[index];
                      return LabResultCard(
                        result: result,
                        onViewPressed: () =>
                            _openFullScreenImage(context, result),
                        onNotesPressed: () =>
                            _showDoctorNotesDialog(context, result),
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
    );
  }

  void _showDoctorNotesDialog(BuildContext context, Result item) {
    final String labInfo = item.labName != null
        ? "\nFrom: ${item.labName}"
        : "";
    final String notes = item.doctorNotes ?? "No specific notes provided.";

    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: item.fileName ?? "Doctor Notes",
          message: "$notes$labInfo",
          type: DialogType.verification,
          buttonText: "Dismiss",
        );
      },
    );
  }

  void _openFullScreenImage(BuildContext context, Result item) {
    if (item.fileUrl == null || item.fileUrl!.isEmpty) return;

    showDialog(
      context: context,
      useSafeArea: false,
      builder: (dialogContext) => Dialog.fullscreen(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              item.fileName ?? "Report Document",
              style: getBoldStyle(color: ColorManager.white, fontSize: 16),
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.network(
                item.fileUrl!,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      "Failed to load image",
                      style: getMediumStyle(
                        color: ColorManager.white,
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
