import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/medicine_details_model/data.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_cubit.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_state.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/widget/cart_quantity_control.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final String medicineId;
  const MedicineDetailsScreen({super.key, required this.medicineId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<PharmacySearchCubit>()
            ..getMedicinesDetails(medicineId: medicineId),
      child: Scaffold(
        backgroundColor: ColorManager.white,
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
                      "Medicine Details",
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
                    "Explore the Medicine's Details",
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
        body: BlocBuilder<PharmacySearchCubit, PharmacySearchState>(
          builder: (context, state) {
            if (state is MedicinesDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            } else if (state is MedicinesDetailsFailure) {
              return Center(
                child: Text(
                  state.message.message,
                  style: getBoldStyle(color: ColorManager.error, fontSize: 16),
                ),
              );
            } else if (state is MedicinesDetailsSuccess) {
              final medicine = state.response.data;
              if (medicine == null) {
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
              return _buildMedicineDetailsContent(context, medicine);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMedicineDetailsContent(BuildContext context, Data medicine) {
    final info = medicine.medicineInfo;
    final usage = medicine.usageInstructions;
    final inStock = medicine.inStock ?? false;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withAlpha(60),
                  blurRadius: 10,
                  offset: const Offset(4, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.medication_rounded,
                        color: ColorManager.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicine.medicineName ?? "N/A",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (medicine.category != null)
                            Text(
                              medicine.category!,
                              style: getMediumStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.storefront_outlined,
                                size: 16,
                                color: ColorManager.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                medicine.pharmacyName ?? "Unknown Pharmacy",
                                style: getMediumStyle(
                                  color: ColorManager.primary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "PRICE  UNIT",
                          style: getMediumStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "${medicine.price ?? 0}",
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "EGP",
                              style: getBoldStyle(
                                color: ColorManager.primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    if (inStock)
                      CartQuantityControl(
                        initialQuantity: 1,
                        minQuantity: 1,
                        maxQuantity: medicine.availableQuantity ?? 10,
                        onQuantityChanged: (newQuantity) {
                          print("Selected quantity: $newQuantity");
                        },
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Out of Stock",
                          style: getBoldStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          if (info != null) ...[
            Text(
              "Medicine Info",
              style: getBoldStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withAlpha(60),
                    blurRadius: 8,
                    offset: const Offset(4, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInfoRow("Brand Name", info.brandName),
                  _buildInfoRow("Manufacturer", info.manufacturer),
                  _buildInfoRow("Concentration", info.concentration),
                  _buildInfoRow("Prescription", info.prescription),
                  _buildInfoRow("Shelf Location", info.shelf, isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          if (usage != null) ...[
            Text(
              "Usage Instructions",
              style: getBoldStyle(color: ColorManager.black, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withAlpha(60),
                    blurRadius: 8,
                    offset: const Offset(4, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInstructionBlock(
                    title: "Indications",
                    content: usage.indications,
                    icon: Icons.info_outline,
                    color: ColorManager.primary
                  ),
                  const SizedBox(height: 12),
                  _buildInstructionBlock(
                    title: "Dosage Instructions",
                    content: usage.dosageInstructions,
                    icon: Icons.medical_services_outlined,
                    color: ColorManager.amber600
                  ),
                  const SizedBox(height: 12),
                  _buildInstructionBlock(
                    title: "Side Effects",
                    content: usage.sideEffects,
                    icon: Icons.warning_amber_rounded,
                    color: ColorManager.red600
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: getMediumStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
              Text(
                value ?? "N/A",
                style: getBoldStyle(color: ColorManager.black, fontSize: 14),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(color: ColorManager.gray, height: 1),
      ],
    );
  }

  Widget _buildInstructionBlock({
    required String title,
    required String? content,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              title,
              style: getBoldStyle(color: color, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            content ?? "N/A",
            style: getRegularStyle(color: ColorManager.darkGray, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
