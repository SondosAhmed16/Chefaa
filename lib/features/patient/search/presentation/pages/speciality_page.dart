import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/search/presentation/widget/speciality_card.dart';
import 'package:flutter/material.dart';

import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialityPage extends StatelessWidget {
  const SpecialityPage({super.key});

  static final List<Map<String, String>> specialityItems = [
    {
      "specialityImage": "assets/images/doctor.png",
      "specialityName": "General",
    },
    {
      "specialityImage": "assets/images/Cardiology.png",
      "specialityName": "Cardiology",
    },
    {
      "specialityImage": "assets/images/Dentistry.png",
      "specialityName": "Dentistry",
    },
    {
      "specialityImage": "assets/images/Dermatology.png",
      "specialityName": "Dermatology",
    },
    {
      "specialityImage": "assets/images/Endocrinology.png",
      "specialityName": "Endocrinology",
    },
    {
      "specialityImage": "assets/images/Gynecology&Obstetrics.png",
      "specialityName": "Gynecology & Obstetrics",
    },
    {
      "specialityImage": "assets/images/Internal_Medicine.png",
      "specialityName": "InternalMedicine",
    },
    {
      "specialityImage": "assets/images/Neurology.png",
      "specialityName": "Neurology",
    },
    {
      "specialityImage": "assets/images/Urology.png",
      "specialityName": "Urology",
    },
    {"specialityImage": "assets/images/ENT.png", "specialityName": "ENT"},
    {
      "specialityImage": "assets/images/Nutrition.png",
      "specialityName": "Nutrition",
    },
    {
      "specialityImage": "assets/images/Pulmonology.png",
      "specialityName": "Pulmonology",
    },
    {
      "specialityImage": "assets/images/Orthopedics.png",
      "specialityName": "Orthopedics",
    },
    {
      "specialityImage": "assets/images/Ophthalmology.png",
      "specialityName": "Ophthalmology",
    },
  ];

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
                  icon: const Icon(
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
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: specialityItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 3,
                childAspectRatio: 0.60,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = specialityItems[index];

                return SpecialityCard(
                  item: item,
                  onTap: () {
                    final specialityName = item["specialityName"] ?? "";

                    context.read<SearchDoctorCubit>().searchDoctors(
                      specialization: specialityName,
                    );

                    Navigator.pop(context, specialityName);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
