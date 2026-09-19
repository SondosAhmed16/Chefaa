import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/patient/profile/presentation/cubit/profile_patient_cubit.dart';
import 'package:chefaa/features/patient/profile/presentation/cubit/profile_patient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showBasicDetailsBottomSheet(BuildContext context) {
  final cubit = BlocProvider.of<PatientProfileCubit>(context);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: ColorManager.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (modalContext) {
      return BlocProvider.value(
        value: cubit,
        child: const BasicDetailsBottomSheet(),
      );
    },
  );
}

class BasicDetailsBottomSheet extends StatefulWidget {
  const BasicDetailsBottomSheet({super.key});

  @override
  State<BasicDetailsBottomSheet> createState() =>
      _BasicDetailsBottomSheetState();
}

class _BasicDetailsBottomSheetState extends State<BasicDetailsBottomSheet> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientProfileCubit, ProfilePatientState>(
      listener: (context, state) {
        if (state is UpdateBasicInfoSuccessState) {
          setState(() {
            isEditing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Updated basic info successfully!')),
          );
        } else if (state is UpdateBasicInfoErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.message ?? 'Update failed')),
          );
        }
      },
      builder: (context, state) {
        final cubit = PatientProfileCubit.get(context);

        return Container(
          padding: EdgeInsets.only(
            top: 16,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: ColorManager.input,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditing ? 'Edit Basic Details' : 'Basic Details',
                      style: getBoldStyle(
                        fontSize: 16,
                        color: ColorManager.black,
                      ),
                    ),
                    if (!isEditing)
                      IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: ColorManager.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  "Name",
                  style: getMediumStyle(color: ColorManager.gray, fontSize: 15),
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  controller: cubit.nameController,
                  text: 'Name',
                  isReadOnly: !isEditing,
                ),
                const SizedBox(height: 12),

                Text(
                  'Gender',
                  style: getMediumStyle(fontSize: 15, color: ColorManager.gray),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: cubit.selectedGender,
                  decoration: InputDecoration(
                    fillColor: ColorManager.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: ColorManager.gray,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: ColorManager.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  items: cubit.genderList
                      .map(
                        (g) => DropdownMenuItem(
                          value: g,
                          child: Text(
                            g,
                            style: getRegularStyle(
                              fontSize: 14,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: isEditing
                      ? (val) => cubit.changeGender(val)
                      : null,
                ),
                const SizedBox(height: 12),

                Text(
                  "Age",
                  style: getMediumStyle(color: ColorManager.gray, fontSize: 15),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: cubit.ageController,
                  text: 'Age',
                  isReadOnly: !isEditing,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),

                Text(
                  "Weight",
                  style: getMediumStyle(color: ColorManager.gray, fontSize: 15),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: cubit.weightController,
                  text: 'Weight (Kg)',
                  isReadOnly: !isEditing,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),

                Text(
                  "Hight",
                  style: getMediumStyle(color: ColorManager.gray, fontSize: 15),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: cubit.heightController,
                  text: 'Height (cm)',
                  isReadOnly: !isEditing,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),

                if (isEditing)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: state is UpdateBasicInfoLoadingState
                          ? null
                          : () {
                              cubit.updateBasicInfo();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: state is UpdateBasicInfoLoadingState
                          ? const CircularProgressIndicator(
                              color: ColorManager.white,
                            )
                          : Text(
                              'Save Changes',
                              style: getBoldStyle(
                                fontSize: 14,
                                color: ColorManager.white,
                              ),
                            ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
