import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/datum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PharmacyCard extends StatelessWidget {
  final Datum pharmacy;
  const PharmacyCard({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    final address = pharmacy.addresses?.isNotEmpty == true
        ? pharmacy.addresses!.first.addressText
        : "--";

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    pharmacy.pharmacyName ?? "Unknown Pharmacy",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: ColorManager.gold,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${pharmacy.rating ?? 0.0}",
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${pharmacy.distanceKm ?? 0.0} km away",
                      style: getRegularStyle(
                        color: ColorManager.gray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svg_images/map.svg",
                  width: 18,
                  height: 18,
                  color: ColorManager.error,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "$address - ${pharmacy.phone ?? "--"}",
                    style: getRegularStyle(
                      color: ColorManager.gray,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.lightBlue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: ColorManager.primary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${pharmacy.deliveryTime ?? 'N/A'}",
                        style: getRegularStyle(
                          color: ColorManager.primary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 148, 244, 174),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: ColorManager.green600,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${pharmacy.availableMedicinesCount ?? 0} medicines",
                        style: getRegularStyle(
                          color: ColorManager.green600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
