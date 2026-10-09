import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/medicine_details_model/medicine_details_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_medicienes_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_search_model.dart';
import 'package:dartz/dartz.dart';

abstract class PharmacySearchRepo {
  Future<Either<ErrorModel, PharmacySearchModel>> pharmacySearch({
    required String searchQuery,
  });

  Future<Either<ErrorModel, PharmacyProfileModel>> getPharmacyProfile({
    required String pharmacyId,
  });

  Future<Either<ErrorModel, PharmacyMedicienesModel>> getPharmacyMedicens({
    required String pharmacyId,
  });

  Future<Either<ErrorModel,MedicineDetailsModel>> getMedicineDetails({required String medicineId});
}
