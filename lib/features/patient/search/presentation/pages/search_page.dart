import 'package:chefaa/features/patient/search/presentation/widget/custom_search_bar.dart';
import 'package:chefaa/features/patient/search/presentation/widget/filter_bar.dart';
import 'package:chefaa/features/patient/search/presentation/widget/results_list.dart';
import 'package:flutter/material.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      SearchDoctorCubit.get(context).searchDoctors();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          // Header / Custom AppBar
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 24,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Text(
                  "Search Doctor",
                  style: getBoldStyle(color: ColorManager.white, fontSize: 18),
                ),
              ],
            ),
          ),

          // Main Search Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  CustomSearchBar(
                    text: "Search Doctor or Specialty",
                    controller: _searchController,
                  ),

                  const SizedBox(height: 12),

                  const FilterBar(),
                  const SizedBox(height: 16),
                  const Expanded(child: ResultsList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
