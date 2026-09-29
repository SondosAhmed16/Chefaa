import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_cubit.dart';
import 'package:flutter/material.dart';

class AppoCard extends StatelessWidget {
  final BookCubit cubit;
  const AppoCard({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage:
                    (cubit.selectedDoctor?.profilePicture != null &&
                        cubit.selectedDoctor!.profilePicture!.isNotEmpty &&
                        cubit.selectedDoctor!.profilePicture!.startsWith(
                          'http',
                        ))
                    ? NetworkImage(cubit.selectedDoctor!.profilePicture!)
                    : const AssetImage("assets/images/doctor.png")
                          as ImageProvider,
              ),

              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.selectedDoctor?.name ?? "No Clinic Selected",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cubit.selectedDoctor?.specialization ?? "",
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: ColorManager.input),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date",
                style: getMediumStyle(color: ColorManager.gray, fontSize: 13),
              ),
              Text(
                cubit.selectedDate ?? " ",
                style: getMediumStyle(color: ColorManager.gray, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Time",
                style: getMediumStyle(color: ColorManager.gray, fontSize: 13),
              ),
              Text(
                cubit.selectedTime ?? " ",
                style: getMediumStyle(color: ColorManager.gray, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: ColorManager.input),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Consultation Fee",
                style: getMediumStyle(color: ColorManager.black, fontSize: 16),
              ),
              Text(
                "${cubit.selectedClinic?.price?? " "}E",
                style: getMediumStyle(color: ColorManager.black, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
