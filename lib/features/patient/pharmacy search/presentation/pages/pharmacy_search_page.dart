import 'dart:async';

import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/datum.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_cubit.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_state.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/widget/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacySearchPage extends StatefulWidget {
  const PharmacySearchPage({super.key});

  @override
  State<PharmacySearchPage> createState() => _PharmacySearchPageState();
}

class _PharmacySearchPageState extends State<PharmacySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _triggerSearch();
    });
  }

  void _triggerSearch() {
    final query = _searchController.text.trim();
    context.read<PharmacySearchCubit>().searchPharmacy(
      query: query.isNotEmpty ? query : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(175),
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
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
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
                  const SizedBox(width: 12),
                  Text(
                    "Find Pharmacy",
                    style: getBoldStyle(
                      color: ColorManager.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Search for Pharmacy You want",
                  style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _searchController,
                  text: "Search Pharmacy",
                  onChanged: _onSearchChanged,
                  isSearch: true,
                  prefixIcon: "assets/icons/search-normal.svg",
                ),
                const SizedBox(height: 20),
                BlocBuilder<PharmacySearchCubit, PharmacySearchState>(
                  builder: (context, state) {
                    if (state is PharmacySearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      );
                    } else if (state is PharmacySearchFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message.message,
                              style: getBoldStyle(
                                color: ColorManager.error,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                _triggerSearch();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is PharmacySearchSuccess) {
                      final List<Datum> pharmacies = state.response.data ?? [];

                      if (pharmacies.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Text(
                              "No Pharmacies Yet",
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pharmacies.length,
                        itemBuilder: (context, index) {
                          print(
                            "Rendering Pharmacy: ${pharmacies[index].pharmacyName}",
                          );
                          return PharmacyCard(pharmacy: pharmacies[index]);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
