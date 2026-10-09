import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/get_medicine_details_usecase.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/get_pharmacy_medicines_usecase.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/get_pharmacy_profile.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/pharmacy_search_usecase.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacySearchCubit extends Cubit<PharmacySearchState> {
  final PharmacySearchUsecase usecase;
  final GetPharmacyProfileUsecase getPharmacyProfileUsecase;
  final GetPharmacyMedicinesUsecase getPharmacyMedicinesUsecase;
  final GetMedicineDetailsUsecase getMedicineDetailsUsecase;

  PharmacySearchCubit({
    required this.usecase,
    required this.getPharmacyProfileUsecase,
    required this.getPharmacyMedicinesUsecase,
    required this.getMedicineDetailsUsecase,
  }) : super(PharmacySearchInitial());

  Future<void> searchPharmacy({String? query}) async {
    if (!isClosed) emit(PharmacySearchLoading());
    final result = await usecase.call(searchQuery: query ?? "");
    result.fold(
      (error) => emit(PharmacySearchFailure(error)),
      (responseModel) => emit(PharmacySearchSuccess(responseModel)),
    );
  }

  Future<void> getPharmacyProfile({required String pharmacyId}) async {
    if (!isClosed) emit(PharmacyProfileLoading());
    final result = await getPharmacyProfileUsecase.call(pharmacyId: pharmacyId);
    result.fold(
      (error) => emit(PharmacyProfileFailure(error)),
      (pharmacy) => emit(PharmacyProfileSuccess(pharmacy)),
    );
  }

  Future<void> getPharmacyMedicines({required String pharmacyId}) async {
    if (!isClosed) emit(PharmacyMedicinesLoading());
    final result = await getPharmacyMedicinesUsecase.call(
      pharmacyId: pharmacyId,
    );
    result.fold(
      (error) => emit(PharmacyMedicinesFailure(error)),
      (medicine) => emit(PharmacyMedicinesSuccess(medicine)),
    );
  }

  Future<void> getMedicinesDetails({required String medicineId}) async {
    if (!isClosed) emit(MedicinesDetailsLoading());
    final result = await getMedicineDetailsUsecase.call(medicineId: medicineId);
    result.fold(
      (error) => emit(MedicinesDetailsFailure(error)),
      (details) => emit(MedicinesDetailsSuccess(details)),
    );
  }
}
