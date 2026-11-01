import 'package:chefaa/features/pharmacy/profile/data/model/get_pharmacy_profile/data.dart';
import 'package:chefaa/features/pharmacy/profile/domain/repository/pharmacy_profile_repo.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/cubit/pharmacy_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyProfileCubit extends Cubit<PharmacyProfileState> {
  final PharmacyProfileRepo repo;
  PharmacyProfileCubit({required this.repo}) : super(PharmacyProfileInitial());

  Data? cachedData;

  Future<void> getPharmacyProfile() async {
    if (!isClosed) emit(PharmacyProfileLoading());

    final result = await repo.getPharmacyProfile();
    result.fold((error) => emit(PharmacyProfileError(error: error)), (
      profileModel,
    ) {
      cachedData = profileModel.data;
      emit(PharmacyProfileSuccess(profile: profileModel));
    });
  }

  Future<void> updatePharmacyProfile({
    required Map<String, dynamic> body,
  }) async {
    if (!isClosed) emit(UpdatePharmacyProfileLoading());

    final result = await repo.updatePharmacyProfile(body: body);

    result.fold((error) => emit(UpdatePharmacyProfileError(error: error)), (
      updateProfileModel,
    ) {
      emit(UpdatePharmacyProfileSuccess(profile: updateProfileModel));
      getPharmacyProfile();
    });
  }

  Future<void> updatePharmacySettings({
    required Map<String, dynamic> body,
  }) async {
    if (!isClosed) emit(UpdatePharmacySettingsLoading());

    final result = await repo.updatePharmacySettings(body: body);

    result.fold((error) => emit(UpdatePharmacySettingsError(error: error)), (
      updateSettingsModel,
    ) {
      emit(UpdatePharmacySettingsSuccess(settingsUpdat: updateSettingsModel));
      getPharmacyProfile();
    });
  }
}
