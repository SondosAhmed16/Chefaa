import 'package:chefaa/features/doctor/profile/data/model/update_profile_model/doctor.dart';
import 'package:chefaa/features/doctor/profile/domain/usecase/get_doctor_profile_usecase.dart';
import 'package:chefaa/features/doctor/profile/domain/usecase/update_doctor_profile_usecase.dart';
import 'package:chefaa/features/doctor/profile/presentation/cubit/doctor_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final GetDoctorProfileUsecase getDoctorProfileUsecase;
  final UpdateDoctorProfileUsecase updateDoctorProfileUsecase;

  DoctorProfileCubit({
    required this.getDoctorProfileUsecase,
    required this.updateDoctorProfileUsecase,
  }) : super(DoctorProfileInitial());

  Doctor? cachedData;

  Future<void> getDoctorProfile() async {
    if (!isClosed) emit(DoctorProfileLoading());

    final result = await getDoctorProfileUsecase.call();
    result.fold((error) => emit(DoctorProfileError(error: error)), (
      profileModel,
    ) {
      cachedData = Doctor(
        image: profileModel.image,
        specialization: profileModel.specialization,
        rating: profileModel.rating,
        clinics: profileModel.clinics?.map((e) => e.id ?? '').toList(),
        reviews: profileModel.reviews,
      );

      emit(DoctorProfileSuccess(profile: profileModel));
    });
  }

  Future<void> updateDoctorProfile({
    required int age,
    required int yearsOfExperience,
    required String gender,
    required String paymentOption,
    required List<String> prePaymentNumbers,
    required List<String> degrees,
    required num clinicConsultationPrice,
    required String contactNumber,
    required String about,
    String? imageUrl,
  }) async {
    if (!isClosed) emit(UpdateDoctorProfileLoading());

    final String? finalImage = imageUrl ?? cachedData?.image;

    final result = await updateDoctorProfileUsecase.call(
      cachedData?.specialization,
      null,
      finalImage,
      cachedData?.clinics?.length,
      cachedData?.rating,
      cachedData?.reviews?.length,
      yearsOfExperience,
      about,
      age,
      paymentOption,
      gender,
      contactNumber,
      degrees,
      prePaymentNumbers,
      clinicConsultationPrice,
    );

    result.fold((error) => emit(UpdateDoctorProfileError(error: error)), (
      updateProfileModel,
    ) {
      emit(UpdateDoctorProfileSuccess(profile: updateProfileModel));
      getDoctorProfile();
    });
  }
}
