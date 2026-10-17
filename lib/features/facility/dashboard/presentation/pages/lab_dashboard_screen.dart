import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/features/facility/dashboard/presentation/cubit/lab_dashboard_cubit.dart';
import 'package:chefaa/features/facility/dashboard/presentation/cubit/lab_dashboard_state.dart';

class LabDashboardScreen extends StatelessWidget {
  final bool? hasUnreadNotifications;

  const LabDashboardScreen({Key? key, this.hasUnreadNotifications})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool showFullNotification = hasUnreadNotifications ?? false;

    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      body: SafeArea(
        child: BlocBuilder<LabDashboardCubit, LabDashboardState>(
          builder: (context, state) {
            if (state is LabDashboardLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            } else if (state is LabDashboardError) {
              return Center(
                child: Text(
                  state.error.message,
                  style: getMediumStyle(
                    fontSize: 14,
                    color: ColorManager.error,
                  ),
                ),
              );
            } else if (state is LabDashboardSuccess) {
              final dashboard = state.labDashboard;
              final stats = dashboard.stats;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome,",
                                      style: getRegularStyle(
                                        fontSize: 14,
                                        color: ColorManager.white.withOpacity(
                                          0.8,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      dashboard.labName ?? "Lab Name",
                                      style: getBoldStyle(
                                        fontSize: 20,
                                        color: ColorManager.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.labNotification);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white.withOpacity(
                                          0.2,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        showFullNotification
                                            ? "assets/icons/notification_full.svg"
                                            : "assets/icons/notification.svg",
                                        width: 22,
                                        height: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: _buildHeaderStatCard(
                                  count:
                                      stats?.todaysRequests?.toString() ?? "0",
                                  title: "Requests today",
                                  countColor: ColorManager.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildHeaderStatCard(
                                  count:
                                      stats?.completedToday?.toString() ?? "0",
                                  title: "Completed",
                                  countColor: ColorManager.cyan,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildHeaderStatCard(
                                  count:
                                      stats?.timeoutRequests?.toString() ?? "0",
                                  title: "Timeout / Ready",
                                  countColor: ColorManager.gold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildBodySectionContainer(
                            title: "Today's Requests List",
                            child:
                                dashboard.todaysRequests == null ||
                                    dashboard.todaysRequests!.isEmpty
                                ? Text(
                                    "No Requests For Today",
                                    style: getRegularStyle(
                                      color: ColorManager.gray,
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: dashboard.todaysRequests!.length,
                                    itemBuilder: (context, index) {
                                      final req =
                                          dashboard.todaysRequests![index];
                                      return ListTile(
                                        title: Text(
                                          req.patientName ?? "Unknown",
                                          style: getBoldStyle(
                                            fontSize: 14,
                                            color: ColorManager.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          req.analysisName ?? "",
                                          style: getRegularStyle(
                                            fontSize: 12,
                                            color: ColorManager.gray,
                                          ),
                                        ),
                                        trailing: Text(
                                          req.status ?? "",
                                          style: getMediumStyle(
                                            fontSize: 11,
                                            color: ColorManager.primary,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 16),

                          _buildBodySectionContainer(
                            title: "Uploaded Results Today",
                            child:
                                dashboard.resultsUploadedToday == null ||
                                    dashboard.resultsUploadedToday!.isEmpty
                                ? Text(
                                    "No Uploaded Results Today",
                                    style: getRegularStyle(
                                      color: ColorManager.gray,
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        dashboard.resultsUploadedToday!.length,
                                    itemBuilder: (context, index) {
                                      final res = dashboard
                                          .resultsUploadedToday![index];
                                      return ListTile(
                                        title: Text(
                                          res.patientName ?? "Unknown",
                                          style: getBoldStyle(
                                            fontSize: 14,
                                            color: ColorManager.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          res.analysisName ?? "",
                                          style: getRegularStyle(
                                            fontSize: 12,
                                            color: ColorManager.gray,
                                          ),
                                        ),
                                        trailing: Text(
                                          res.uploadedAt ?? "",
                                          style: getRegularStyle(
                                            fontSize: 11,
                                            color: ColorManager.gray,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 16),

                          _buildBodySectionContainer(
                            title: "Timeout / Ready Patients",
                            child:
                                stats?.timeoutPatients == null ||
                                    stats!.timeoutPatients!.isEmpty
                                ? Text(
                                    "No Timeout Tests",
                                    style: getRegularStyle(
                                      color: ColorManager.gray,
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: stats.timeoutPatients!.length,
                                    itemBuilder: (context, index) {
                                      final timeoutPatient =
                                          stats.timeoutPatients![index];
                                      return ListTile(
                                        title: Text(
                                          timeoutPatient.patientName ??
                                              "Unknown",
                                          style: getBoldStyle(
                                            fontSize: 14,
                                            color: ColorManager.black,
                                          ),
                                        ),
                                        subtitle: Text(
                                          timeoutPatient.tests ?? "",
                                          style: getRegularStyle(
                                            fontSize: 12,
                                            color: ColorManager.gray,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeaderStatCard({
    required String count,
    required String title,
    required Color countColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: ColorManager.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count, style: getBoldStyle(fontSize: 24, color: countColor)),
          const SizedBox(height: 4),
          Text(
            title,
            style: getRegularStyle(
              fontSize: 11,
              color: ColorManager.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildBodySectionContainer({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.input),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getBoldStyle(fontSize: 15, color: ColorManager.primary),
          ),
          const Divider(color: ColorManager.input),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}
