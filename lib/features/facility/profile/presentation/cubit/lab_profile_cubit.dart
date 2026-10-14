import 'package:chefaa/features/facility/profile/data/model/address.dart';
import 'package:chefaa/features/facility/profile/data/model/profile_data.dart';
import 'package:chefaa/features/facility/profile/data/model/working_hours.dart';
import 'package:chefaa/features/facility/profile/domain/usecase/get_lab_profile_usecase.dart';
import 'package:chefaa/features/facility/profile/domain/usecase/update_lab_profile_usecase.dart'; // تأكد من استيراد الـ Usecase
import 'package:chefaa/features/facility/profile/presentation/cubit/lab_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabProfileCubit extends Cubit<LabProfileState> {
  final GetLabProfileUsecase getLabProfileUsecase;
  final UpdateLabProfileUsecase updateLabProfileUsecase;

  LabProfileCubit({
    required this.getLabProfileUsecase,
    required this.updateLabProfileUsecase,
  }) : super(LabProfileInitial());

  ProfileData? cachedProfile;

  Future<void> getLabProfile() async {
    if (!isClosed) emit(LabProfileLoading());

    final result = await getLabProfileUsecase.call();

    result.fold((error) => emit(LabProfileError(error: error)), (response) {
      cachedProfile = response.profileData;
      emit(LabProfileSuccess(response: response));
    });
  }

  Future<void> updateProfile({
    String? name,
    String? phoneNumber,
    String? facilityType,
    WorkingHours? workingHours,
    String? commercialRegisterNumber,
    String? licenseValidUntil,
    String? medicalDirectorName,
    String? directorProfessionalId,
    bool? homeSampleCollection,
    bool? aiRecommendations,
    bool? insuranceAccepted,
    List<String>? paymentMethods,
    List<Address>? addresses,
  }) async {
    if (!isClosed) emit(LabProfileUpdating());

    final result = await updateLabProfileUsecase.call(
      name: name ?? cachedProfile?.name,
      phoneNumber: phoneNumber ?? cachedProfile?.phoneNumber,
      facilityType: facilityType ?? cachedProfile?.facilityType,
      workingHours: workingHours ?? cachedProfile?.workingHours,
      commercialRegisterNumber:
          commercialRegisterNumber ?? cachedProfile?.commercialRegisterNumber,
      medicalDirectorName:
          medicalDirectorName ?? cachedProfile?.medicalDirectorName,
      directorProfessionalId:
          directorProfessionalId ?? cachedProfile?.directorProfessionalId,
      homeSampleCollection:
          homeSampleCollection ?? cachedProfile?.settings?.homeSampleCollection,
      aiRecommendations:
          aiRecommendations ?? cachedProfile?.settings?.aiRecommendations,
      insuranceAccepted:
          insuranceAccepted ?? cachedProfile?.settings?.insuranceAccepted,
      paymentMethods: paymentMethods ?? cachedProfile?.paymentMethods,
      addresses: addresses ?? cachedProfile?.addresses,
    );

    result.fold((error) => emit(LabProfileUpdateError(error: error)), (
      response,
    ) {
      cachedProfile = response.profileData;
      emit(
        LabProfileUpdateSuccess(
          response: response,
          message: "Profile updated successfully.",
        ),
      );
    });
  }
}
