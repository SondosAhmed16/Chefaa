import 'package:chefaa/features/doctor/brief/data/model/brief_section.dart';
import 'package:chefaa/features/doctor/brief/presentation/cubit/doctor_brief_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/doctor/brief/presentation/cubit/doctor_brief_cubit.dart';

class DoctorBriefScreen extends StatelessWidget {
  const DoctorBriefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120 + topPadding),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: topPadding + 8,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: const BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20,
                      color: ColorManager.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Daily Briefing",
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
                child: Text(
                  "Explore your daily overview and updates",
                  style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<DoctorBriefCubit, DoctorBriefState>(
        builder: (context, state) {
          if (state is GetDoctorBriefLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          } else if (state is GetDoctorBriefSuccess) {
            final briefText = state.doctorBrief.brief ?? '';
            List<BriefSection> parsedSections = parseBriefText(briefText);

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: parsedSections.length,
              itemBuilder: (context, index) {
                final section = parsedSections[index];
                bool isFinancial = section.title.contains("Financial Snapshot");
                bool isWeekGlance = section.title.contains("Week at a Glance");
                bool isClinicStatus = section.title.contains("Clinic Status");
                bool isActionItems = section.title.contains("Action Items");
                bool isTodaySchedule = section.title.contains(
                  "Today's Schedule",
                );

                // فلترة عناصر الـ listItems لتجنب أي رموز فارغة أو `--`
                final validListItems = section.listItems
                    .where((item) => item.trim().isNotEmpty && item.trim() != "--")
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.gray.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.title,
                          style: getBoldStyle(
                            fontSize: 16,
                            color: ColorManager.black,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 1. قسم جدول اليوم (Today's Schedule)
                        if (isTodaySchedule) ...[
                          if (section.content.isNotEmpty && section.content != "--") ...[
                            Text(
                              section.content,
                              style: getRegularStyle(
                                fontSize: 13,
                                color: ColorManager.darkGray,
                              ),
                            ),
                          ],
                          if (validListItems.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: validListItems
                                  .map(
                                    (item) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 4.0,
                                      ),
                                      child: Text(
                                        "• $item",
                                        style: getMediumStyle(
                                          fontSize: 13,
                                          color: ColorManager.darkGray,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ] 
                        // 2. قسم الإجراءات المطلوبة (Action Items)
                        else if (isActionItems) ...[
                          if (section.content.isNotEmpty) ...[
                            Text(
                              section.content,
                              style: getRegularStyle(
                                fontSize: 13,
                                color: ColorManager.darkGray,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                          if (validListItems.isNotEmpty) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: validListItems
                                  .map(
                                    (item) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 6.0,
                                      ),
                                      child: Text(
                                        "• $item",
                                        style: getMediumStyle(
                                          fontSize: 13,
                                          color: ColorManager.darkGray,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ] 
                        // 3. نظرة عامة على الأسبوع (Week at a Glance)
                        else if (isWeekGlance) ...[
                          if (section.content.isNotEmpty) ...[
                            Text(
                              section.content,
                              style: getRegularStyle(
                                fontSize: 13,
                                color: ColorManager.darkGray,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          _buildSubBoxes(
                            total: section.totalAppointments ?? "0",
                            completed: section.completedAppointments ?? "0",
                            pending: section.pendingClinics ?? "0",
                          ),
                        ] 
                        // 4. حالة العيادات (Clinic Status) - عرض الكونتينر الثاني والثالث والرابع فقط
                        else if (isClinicStatus) ...[
                          Builder(
                            builder: (context) {
                              // اخذ العناصر من الثاني للاخير (تخطى العنصر الأول الخاص بالإجمالي)
                              final clinicItems = validListItems.length > 1 
                                  ? validListItems.sublist(1) 
                                  : validListItems;

                              return Column(
                                children: clinicItems.map((clinicItem) {
                                  return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.lightGray,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: ColorManager.input,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: CircleAvatar(
                                            radius: 4,
                                            backgroundColor: ColorManager.amber600,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                clinicItem,
                                                style: getMediumStyle(
                                                  fontSize: 13,
                                                  color: ColorManager.darkGray,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "Status: Pending approval",
                                                style: getBoldStyle(
                                                  fontSize: 12,
                                                  color: ColorManager.amber600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ] 
                        // 5. باقي الأقسام العادية (مثل Motivational Closing Line)
                        else ...[
                          if (section.content.isNotEmpty)
                            Text(
                              section.content,
                              style: getRegularStyle(
                                fontSize: 13,
                                color: ColorManager.darkGray,
                              ),
                            ),
                        ],

                        // القسم المالي (Financial Snapshot)
                        if (isFinancial) ...[
                          const SizedBox(height: 10),
                          _buildFinancialRow(
                            "Confirmed Revenue",
                            "${section.confirmedRevenue} EGP",
                            ColorManager.green600,
                            ColorManager.green100,
                          ),
                          const SizedBox(height: 8),
                          _buildFinancialRow(
                            "Expected Revenue",
                            "${section.expectedRevenue} EGP",
                            ColorManager.blue600,
                            ColorManager.lightBlue100,
                          ),
                          const SizedBox(height: 8),
                          _buildFinancialRow(
                            "Platform Fee Owed",
                            "${section.platformFee} EGP",
                            ColorManager.error,
                            ColorManager.lightRed,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is GetDoctorBriefFailure) {
            return Center(
              child: Text(
                state.errorModel.message,
                style: getMediumStyle(fontSize: 14, color: ColorManager.error),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildSubBoxes({
    required String total,
    required String completed,
    required String pending,
  }) {
    return Row(
      children: [
        Expanded(
          child: _miniBox(
            "Appointments",
            total,
            ColorManager.lightBlue100,
            ColorManager.blue600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _miniBox(
            "Completed",
            completed,
            ColorManager.green100,
            ColorManager.green600,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _miniBox(
            "Pending",
            pending,
            ColorManager.amber50,
            ColorManager.amber600,
          ),
        ),
      ],
    );
  }

  Widget _miniBox(String label, String value, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: getBoldStyle(fontSize: 16, color: textColor)),
          const SizedBox(height: 4),
          Text(
            label,
            style: getMediumStyle(fontSize: 11, color: ColorManager.gray600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

Widget _buildFinancialRow(
  String label,
  String amount,
  Color textColor,
  Color bgColor,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: bgColor.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: bgColor, width: 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getMediumStyle(fontSize: 13, color: ColorManager.darkGray),
        ),
        Text(amount, style: getBoldStyle(fontSize: 14, color: textColor)),
      ],
    ),
  );
}