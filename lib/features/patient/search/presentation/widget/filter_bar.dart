import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:flutter/material.dart';

import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  String? selectedGender;
  String? selectedSpecialization;
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    final cubit = SearchDoctorCubit.get(context);
    final filters = ['Specialty', 'Gender', 'Location'];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];

          return GestureDetector(
            onTap: () async {
              if (filter == 'Specialty') {
                final result =
                    await Navigator.pushNamed(
                          context,
                          Routes.specialityPage,
                          arguments: context.read<SearchDoctorCubit>(),
                        )
                        as String?;

                if (result != null) {
                  setState(() => selectedSpecialization = result);
                  cubit.searchDoctors(
                    specialization: result,
                    gender: selectedGender,
                    location: selectedLocation,
                  );
                }
              } else if (filter == 'Gender') {
                _showGenderMenu(context, cubit);
              } else if (filter == 'Location') {
                final result =
                    await Navigator.pushNamed(context, Routes.locationFilter)
                        as String?;

                if (result != null && result.isNotEmpty) {
                  setState(() => selectedLocation = result);
                  cubit.searchDoctors(
                    location: result,
                    gender: selectedGender,
                    specialization: selectedSpecialization,
                  );
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: selectedLocation != null && filter == 'Location'
                    ? ColorManager.primary.withOpacity(0.1)
                    : ColorManager.lightGray,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: ColorManager.input),
              ),
              child: Center(
                child: Text(
                  filter == 'Gender' && selectedGender != null
                      ? selectedGender!
                      : filter == 'Specialty' && selectedSpecialization != null
                      ? selectedSpecialization!
                      : filter == 'Location' && selectedLocation != null
                      ? selectedLocation!
                      : filter,
                  style: TextStyle(
                    color:
                        (filter == 'Location' && selectedLocation != null) ||
                            (filter == 'Gender' && selectedGender != null) ||
                            (filter == 'Specialty' &&
                                selectedSpecialization != null)
                        ? ColorManager.primary
                        : ColorManager.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showGenderMenu(BuildContext context, SearchDoctorCubit cubit) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 200, 100, 0),
      items: ['male', 'female'].map((gender) {
        return PopupMenuItem<String>(value: gender, child: Text(gender));
      }).toList(),
    ).then((selected) {
      if (selected != null) {
        setState(() => selectedGender = selected);
        cubit.searchDoctors(
          gender: selected,
          specialization: selectedSpecialization,
          location: selectedLocation,
        );
      }
    });
  }
}
