import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_cubit.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_state.dart';
import 'package:chefaa/features/facility/requests/presentation/cubit/requests_cubit.dart';
import 'package:chefaa/features/facility/requests/presentation/cubit/requests_state.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({super.key});

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final TextEditingController phoneController = TextEditingController();
  final List<SelectedServiceModel> selectedServices = [];

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(
          'Add New Request',
          style: getBoldStyle(fontSize: 18, color: ColorManager.white),
        ),
        iconTheme: const IconThemeData(color: ColorManager.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Phone',
                style: getMediumStyle(
                  fontSize: 14,
                  color: ColorManager.darkGray,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                controller: phoneController,
                text: 'Enter patient phone number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              Text(
                'Select Services',
                style: getMediumStyle(
                  fontSize: 14,
                  color: ColorManager.darkGray,
                ),
              ),
              const SizedBox(height: 6),

              BlocBuilder<LabServicesCubit, LabServicesState>(
                builder: (context, state) {
                  if (state is LabServicesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<dynamic> allServices = [];
                  if (state is LabServicesSuccess) {
                    allServices.addAll(state.services.data?.labTests ?? []);
                    allServices.addAll(state.services.data?.radiology ?? []);
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: ColorManager.gray, width: 1.2),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(
                          'Choose a service to add',
                          style: getRegularStyle(
                            fontSize: 16,
                            color: ColorManager.gray,
                          ),
                        ),
                        items: allServices.map((service) {
                          final id = service is Map
                              ? (service['_id'] ?? service['id'])
                              : service.id;
                          final name = service is Map
                              ? service['name']
                              : service.name;

                          return DropdownMenuItem<String>(
                            value: id,
                            child: Text(
                              name ?? '',
                              style: getRegularStyle(
                                fontSize: 16,
                                color: ColorManager.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (selectedId) {
                          if (selectedId != null) {
                            final selectedObj = allServices.firstWhere(
                              (s) =>
                                  (s is Map ? (s['_id'] ?? s['id']) : s.id) ==
                                  selectedId,
                            );
                            final serviceName = selectedObj is Map
                                ? selectedObj['name']
                                : selectedObj.name;

                            if (!selectedServices.any(
                              (s) => s.id == selectedId,
                            )) {
                              setState(() {
                                selectedServices.add(
                                  SelectedServiceModel(
                                    id: selectedId,
                                    name: serviceName,
                                  ),
                                );
                              });
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              if (selectedServices.isNotEmpty) ...[
                Text(
                  'Selected Services:',
                  style: getMediumStyle(fontSize: 13, color: ColorManager.gray),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: selectedServices.map((service) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.lightBlue,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ColorManager.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            service.name,
                            style: getMediumStyle(
                              fontSize: 13,
                              color: ColorManager.primary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedServices.remove(service);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: ColorManager.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
              ],

              const SizedBox(height: 20),

              BlocConsumer<RequestsCubit, RequestsState>(
                listener: (context, state) {
                  if (state is AddSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Request added successfully'),
                        backgroundColor: ColorManager.lightGreen,
                      ),
                    );
                    Navigator.pop(context);
                  } else if (state is AddError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.message),
                        backgroundColor: ColorManager.error,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is AddLoading;
                  return CustemButton(
                    text: 'Save Request',
                    isLoading: isLoading,
                    onPressed: () {
                      if (phoneController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter patient phone'),
                          ),
                        );
                        return;
                      }
                      if (selectedServices.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select at least one service'),
                          ),
                        );
                        return;
                      }

                      final Map<String, dynamic> body = {
                        "patientPhone": phoneController.text.trim(),
                        "serviceIds": selectedServices
                            .map((s) => s.id)
                            .toList(),
                      };

                      context.read<RequestsCubit>().addRequest(body: body);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedServiceModel {
  final String id;
  final String name;

  SelectedServiceModel({required this.id, required this.name});
}
