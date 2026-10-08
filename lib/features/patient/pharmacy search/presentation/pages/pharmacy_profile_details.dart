import 'package:chefaa/core/DI/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/profile_data.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_cubit.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PharmacyProfileDetails extends StatelessWidget {
  final String pharmacyId;
  const PharmacyProfileDetails({super.key, required this.pharmacyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PharmacySearchCubit>(
      create: (_) =>
          getIt<PharmacySearchCubit>()
            ..getPharmacyProfile(pharmacyId: pharmacyId),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              right: 16,
              bottom: 20,
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
              mainAxisAlignment: MainAxisAlignment.end,
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
                    Text(
                      "Pharmacy Details",
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Explore the pharmacy's services and location",
                    style: getMediumStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<PharmacySearchCubit, PharmacySearchState>(
          builder: (context, state) {
            if (state is PharmacyProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            } else if (state is PharmacyProfileFailure) {
              return Center(
                child: Text(
                  state.message.message,
                  style: getBoldStyle(color: ColorManager.error, fontSize: 16),
                ),
              );
            } else if (state is PharmacyProfileSuccess) {
              final pharmacy = state.pharmacyProfile.data;

              if (pharmacy == null) {
                return Center(
                  child: Text(
                    "No Details Found",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 18,
                    ),
                  ),
                );
              }
              return _buildPharmacyDetailsContent(context, pharmacy);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildPharmacyDetailsContent(BuildContext context, Data pharmacy) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.local_pharmacy_rounded,
                        color: ColorManager.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pharmacy.pharmacyName ?? '',
                                style: getBoldStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              // Rating Chip
                              if (pharmacy.rating != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: ColorManager.gold,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${pharmacy.rating} (${pharmacy.totalReviews ?? 0})",
                                        style: getBoldStyle(
                                          color: ColorManager.amber600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg_images/map.svg",
                                width: 20,
                                height: 20,
                                color: ColorManager.error,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  pharmacy.addressText ?? 'No address provided',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: getRegularStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildChip(
                      icon: Icons.circle,
                      iconColor: pharmacy.openNow == true
                          ? Colors.green
                          : ColorManager.red600,
                      label: pharmacy.openNow == true ? "Open Now" : "Closed",
                      bgColor:
                          (pharmacy.openNow == true
                                  ? Colors.green
                                  : ColorManager.red600)
                              .withValues(alpha: 0.1),
                    ),
                    const SizedBox(width: 8),
                    _buildChip(
                      icon: Icons.verified_user_outlined,
                      iconColor: ColorManager.primary,
                      label: "Accepts Insurance & Rx",
                      bgColor: ColorManager.primary.withValues(alpha: 0.1),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              side: const BorderSide(color: ColorManager.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.phone_outlined, color: ColorManager.primary),
            label: Text(
              "Call Pharmacy ",
              style: getBoldStyle(color: ColorManager.primary, fontSize: 14),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.pharmacyMedicines,
                arguments: {
                  'pharmacyId': pharmacyId ,
                  'pharmacyName': pharmacy.pharmacyName ?? 'Pharmacy Medicines',
                },
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: ColorManager.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(
              Icons.medical_services_outlined,
              color: Colors.white,
            ),
            label: Text(
              "View Medicines (${pharmacy.availableMedicinesCount ?? 0})",
              style: getBoldStyle(color: Colors.white, fontSize: 14),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            "Pharmacy details",
            style: getBoldStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                // Phone
                _buildDetailRow(
                  label: "Phone",
                  child: Text(
                    pharmacy.phone ?? 'N/A',
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
                const Divider(height: 1, thickness: 0.5),

                // Working Hours
                _buildDetailRow(
                  label: "Working hours",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                        (pharmacy.workingHours != null &&
                            pharmacy.workingHours!.isNotEmpty)
                        ? pharmacy.workingHours!
                              .map(
                                (wh) => Text(
                                  "${wh.days}: ${wh.time}",
                                  style: getBoldStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                              .toList()
                        : [
                            Text(
                              pharmacy.alwaysOpen == true
                                  ? "24/7 Service"
                                  : "Closed",
                              style: getBoldStyle(
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                            ),
                          ],
                  ),
                ),
                const Divider(height: 1, thickness: 0.5),

                _buildDetailRow(
                  label: "Delivery",
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Available · ${pharmacy.deliveryTime ?? '30 min'}",
                      style: getMediumStyle(
                        color: Colors.green.shade800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, thickness: 0.5),

                _buildDetailRow(
                  label: "Delivery fee",
                  child: Text(
                    pharmacy.deliveryFee == 0
                        ? "Free Delivery"
                        : "${pharmacy.deliveryFee} EGP",
                    style: getBoldStyle(color: Colors.black87, fontSize: 13),
                  ),
                ),
                const Divider(height: 1, thickness: 0.5),

                if (pharmacy.about != null && pharmacy.about!.isNotEmpty)
                  _buildDetailRow(
                    label: "About",
                    child: Text(
                      pharmacy.about!,
                      style: getRegularStyle(
                        color: Colors.black87,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required Color iconColor,
    required String label,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: iconColor),
          const SizedBox(width: 6),
          Text(label, style: getMediumStyle(color: iconColor, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: getMediumStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: child),
          ),
        ],
      ),
    );
  }
}
