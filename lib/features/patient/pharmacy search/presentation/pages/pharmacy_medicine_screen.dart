import 'package:chefaa/core/DI/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/medicine.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_cubit.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_state.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/widget/medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyMedicineScreen extends StatelessWidget {
  final String pharmacyId;
  final String pharmacyName;

  const PharmacyMedicineScreen({
    super.key,
    required this.pharmacyId,
    required this.pharmacyName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PharmacySearchCubit>(
      create: (_) =>
          getIt<PharmacySearchCubit>()
            ..getPharmacyMedicines(pharmacyId: pharmacyId),
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
                    Expanded(
                      child: Text(
                        pharmacyName,
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Medicines",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 18),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<PharmacySearchCubit, PharmacySearchState>(
                    builder: (context, state) {
                      if (state is PharmacyMedicinesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        );
                      } else if (state is PharmacyMedicinesFailure) {
                        return Center(
                          child: Text(
                            state.message.message,
                            style: getBoldStyle(
                              color: ColorManager.error,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (state is PharmacyMedicinesSuccess) {
                        final List<Medicine> medicines =
                            state.response.data?.medicines ?? [];

                        if (medicines.isEmpty) {
                          return Center(
                            child: Text(
                              "No medicines available right now",
                              style: getMediumStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: ColorManager.lightGray,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: medicines.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final medicine = medicines[index];
                              return MedicineCard(
                                medicine: medicine,
                                onAddToCart: () {
                                  // Add to cart logic
                                },
                                onTap: () {},
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
