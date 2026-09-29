import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';
import 'package:chefaa/features/patient/search/presentation/widget/custom_search_bar.dart';
import 'package:chefaa/features/patient/search/presentation/widget/filter_bar.dart';
import 'package:chefaa/features/patient/search/presentation/widget/results_list.dart';
import 'package:flutter/material.dart';

class SearchDoctorPage extends StatefulWidget {
  const SearchDoctorPage({super.key});

  @override
  State<SearchDoctorPage> createState() => _SearchDoctorPageState();
}

class _SearchDoctorPageState extends State<SearchDoctorPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose Doctor",
                style: getBoldStyle(color: ColorManager.black, fontSize: 22),
              ),
              const SizedBox(height: 4),
              Text(
                "Select your healthcare provider.",
                style: getSemiBoldStyle(
                  color: ColorManager.gray, 
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              CustomSearchBar(
                text: "Search Doctor or Specialty",
                controller: _searchController,
              ),
              const SizedBox(height: 12),
              const FilterBar(),
              const SizedBox(height: 16),
              const Expanded(
                child: ResultsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}