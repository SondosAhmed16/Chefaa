import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

import 'package:chefaa/features/patient/search/domain/entity/doctor_entity.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.doctor});

  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage:
                    (doctor.profilePicture != null &&
                        doctor.profilePicture!.isNotEmpty &&
                        doctor.profilePicture!.startsWith('http'))
                    ? NetworkImage(doctor.profilePicture!)
                    :  AssetImage('assets/images/doctor.png')
                          as ImageProvider,
                radius: 30,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialization,
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: 14,
                      ),
                    ),
                    if (doctor.bio != null && doctor.bio!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        doctor.bio!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getRegularStyle(
                          color: ColorManager.gray,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: ColorManager.input, height: 1),
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Book Now',
                  style: getSemiBoldStyle(
                    color: ColorManager.primary,
                    fontSize: 18,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
