import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';

import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const CustomSearchBar({
    super.key,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = SearchDoctorCubit.get(context);

    return CustomTextField(
      prefixIcon: "assets/icons/search-normal.svg",
      isSearch: true,
      controller: controller,
      text: text,
      textInputAction: TextInputAction.search,
      onPressSearch: () {
        if (controller.text.trim().isNotEmpty) {
          cubit.searchDoctors(searchText: controller.text.trim());
        }
      },
      onChanged: (value) {
        cubit.searchDoctors(searchText: value.trim());
      },
    );
  }
}
