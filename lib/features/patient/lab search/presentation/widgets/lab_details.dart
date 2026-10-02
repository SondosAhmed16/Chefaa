import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/widgets/get_image.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/widgets/lab_info_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabDetails extends StatelessWidget {
  final CenterModel center;
  const LabDetails({super.key, required this.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),

      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20, top: 10),
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: ColorManager.input,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(25),
                    child: Image.asset(
                      center.imagePath,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        center.name ?? "",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: ColorManager.primary,
                          ),

                          const SizedBox(width: 5),
                          Text(
                            center.distance ?? "",
                            style: getRegularStyle(
                              color: ColorManager.gray,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: ColorManager.gold,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            (center.rating ?? 0).toString(),
                            style: getSemiBoldStyle(
                              color: ColorManager.gray,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.lightBlue.withValues(
                                alpha: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              center.facilityType?.toUpperCase() ?? "LAB",
                              style: getBoldStyle(
                                color: ColorManager.primary,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: ColorManager.input, thickness: 1),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Center",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabInfoChip(
                        icon: Icons.payments_rounded,
                        title: "Starting from",
                        subtitle: "EGP ${center.minPrice ?? 0}",
                        iconColor: ColorManager.lightGreen,
                      ),
                      LabInfoChip(
                        icon: Icons.access_time_rounded,
                        title: "Next Slot",
                        subtitle: center.nextSlot ?? "Available Now",
                        iconColor: ColorManager.blue600,
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabInfoChip(
                        icon: Icons.home_repair_service_rounded,
                        title: "Home Visit",
                        subtitle: (center.homeServiceAvailable == true)
                            ? "Available"
                            : "Not Available",
                        iconColor: ColorManager.purple600,
                      ),
                      LabInfoChip(
                        icon: Icons.health_and_safety_rounded,
                        title: "Insurance",
                        subtitle: (center.insuranceAccepted == true)
                            ? "Accepted"
                            : "Not Accepted",
                        iconColor: ColorManager.mint600,
                      ),
                    ],
                  ),

                  if (center.availableTags != null &&
                      center.availableTags!.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      "Available Services",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: center.availableTags!.map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            border: Border.all(color: ColorManager.input),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tag.name ?? "",
                            style: getMediumStyle(
                              color: ColorManager.darkGray,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
