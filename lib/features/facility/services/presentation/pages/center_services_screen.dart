import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_cubit.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_state.dart';

class LabServicesScreen extends StatelessWidget {
  const LabServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: ColorManager.primary,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              bottom: 20,
              left: 16,
              right: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: ColorManager.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: ColorManager.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Services',
                        style: getBoldStyle(
                          fontSize: 22,
                          color: ColorManager.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Manage prices & availability',
                        style: getRegularStyle(
                          fontSize: 13,
                          color: ColorManager.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocConsumer<LabServicesCubit, LabServicesState>(
              listener: (context, state) {
                if (state is LabServicesToggleSuccess) {
                  context.read<LabServicesCubit>().getCenterServices();
                } else if (state is LabServicesToggleError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.message),
                      backgroundColor: ColorManager.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LabServicesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LabServicesError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        state.error.message,
                        style: getMediumStyle(
                          fontSize: 16,
                          color: ColorManager.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (state is LabServicesSuccess ||
                    state is LabServicesToggleLoading ||
                    state is LabServicesToggleSuccess) {
                  final labTests = state is LabServicesSuccess
                      ? (state.services.data?.labTests ?? [])
                      : (context.read<LabServicesCubit>().state
                                is LabServicesSuccess
                            ? ((context.read<LabServicesCubit>().state
                                          as LabServicesSuccess)
                                      .services
                                      .data
                                      ?.labTests ??
                                  [])
                            : []);

                  final radiology = state is LabServicesSuccess
                      ? (state.services.data?.radiology ?? [])
                      : (context.read<LabServicesCubit>().state
                                is LabServicesSuccess
                            ? ((context.read<LabServicesCubit>().state
                                          as LabServicesSuccess)
                                      .services
                                      .data
                                      ?.radiology ??
                                  [])
                            : []);

                  if (labTests.isEmpty && radiology.isEmpty) {
                    return Center(
                      child: Text(
                        'No Services Avilable Now ',
                        style: getRegularStyle(
                          fontSize: 16,
                          color: ColorManager.gray,
                        ),
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      if (labTests.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(
                              Icons.science_outlined,
                              color: ColorManager.primary,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Lab Tests',
                              style: getBoldStyle(
                                fontSize: 18,
                                color: ColorManager.darkGray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: labTests.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: ColorManager.input,
                            ),
                            itemBuilder: (context, index) {
                              final test = labTests[index];
                              final isActive = test.isActive ?? false;

                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Text(
                                  test.name ?? '',
                                  style: getSemiBoldStyle(
                                    fontSize: 15,
                                    color: ColorManager.black,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (test.instructions != null &&
                                        test.instructions!.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.info_outline,
                                            size: 13,
                                            color: ColorManager.gray,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              test.instructions!,
                                              style: getRegularStyle(
                                                fontSize: 12,
                                                color: ColorManager.gray,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (test.estimatedTime != null &&
                                        test.estimatedTime!.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 13,
                                            color: ColorManager.gray,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${test.estimatedTime!} Hour",
                                            style: getRegularStyle(
                                              fontSize: 12,
                                              color: ColorManager.gray,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${test.price ?? 0} EGP',
                                      style: getBoldStyle(
                                        fontSize: 15,
                                        color: ColorManager.lightGreen,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Switch(
                                      value: isActive,
                                      activeColor: ColorManager.primary,
                                      inactiveThumbColor: ColorManager.darkGray,
                                      onChanged: (bool value) {
                                        context
                                            .read<LabServicesCubit>()
                                            .toggleService(
                                              serviceId: test.id ?? '',
                                            );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      if (radiology.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(
                              Icons.medical_services_outlined,
                              color: ColorManager.primary,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Radiology Tests',
                              style: getBoldStyle(
                                fontSize: 18,
                                color: ColorManager.darkGray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: radiology.length,
                            separatorBuilder: (context, index) => const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                              color: ColorManager.input,
                            ),
                            itemBuilder: (context, index) {
                              final item = radiology[index];
                              final name = item['name'] ?? '';
                              final price = item['price'] ?? 0;
                              final id = item['_id'] ?? item['id'] ?? '';
                              final isActive = item['isActive'] ?? false;
                              final instructions = item['instructions'];
                              final estimatedTime = item['estimatedTime'];
                              final sessionDuration = item['sessionDuration'];
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                title: Text(
                                  name,
                                  style: getSemiBoldStyle(
                                    fontSize: 15,
                                    color: ColorManager.black,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (instructions != null &&
                                        instructions!.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.info_outline,
                                            size: 13,
                                            color: ColorManager.gray,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              instructions!,
                                              style: getRegularStyle(
                                                fontSize: 12,
                                                color: ColorManager.gray,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (estimatedTime != null &&
                                        estimatedTime!.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 13,
                                            color: ColorManager.gray,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${estimatedTime!} Hour",
                                            style: getRegularStyle(
                                              fontSize: 12,
                                              color: ColorManager.gray,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (sessionDuration != null &&
                                        sessionDuration!.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 13,
                                            color: ColorManager.gray,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${sessionDuration!} Hour",
                                            style: getRegularStyle(
                                              fontSize: 12,
                                              color: ColorManager.gray,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${price ?? 0} EGP',
                                      style: getBoldStyle(
                                        fontSize: 15,
                                        color: ColorManager.lightGreen,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Switch(
                                      value: isActive,
                                      activeColor: ColorManager.primary,
                                      inactiveThumbColor: ColorManager.darkGray,
                                      onChanged: (bool value) {
                                        context
                                            .read<LabServicesCubit>()
                                            .toggleService(serviceId: id ?? '');
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
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
}
