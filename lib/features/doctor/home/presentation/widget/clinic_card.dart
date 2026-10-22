import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/doctor/home/data/model/clinics_model/clinics.dart';
import 'package:chefaa/features/doctor/home/presentation/widget/clinic_open.dart';
import 'package:chefaa/features/doctor/home/presentation/widget/days_avaliable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClinicCard extends StatelessWidget {
  final Clinics clinic;
  final VoidCallback onPressed;
  const ClinicCard({super.key, required this.clinic, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final days = clinic.defaultSchedule?.days ?? [];
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.lightGray,

          borderRadius: BorderRadius.circular(25),

          boxShadow: [
            BoxShadow(
              color: ColorManager.gray.withAlpha(80),

              blurRadius: 10,

              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          clinic.name ?? " ",
                          style: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: ColorManager.error,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                clinic.address ?? "",
                                style: getRegularStyle(
                                  color: ColorManager.gray,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: ColorManager.gray,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      clinic.city ?? "",
                      style: getMediumStyle(
                        color: ColorManager.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 30,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final day = days[index];
                      if (day.isActive != true) {
                        return const SizedBox.shrink();
                      }
                      return DaysAvaliable(
                        day: day.day?.substring(0, 3) ?? "",
                        avaliable: true,
                      );
                    },
                    separatorBuilder: (_, _) => 7.horizontalSpace,
                    itemCount: days.length,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ClinicOpen(days: clinic.defaultSchedule?.days ?? []),
            ],
          ),
        ),
      ),
    );
  }
}
