import 'package:chefaa/features/patient/search/data/model/model.dart';

abstract class SearchDoctorRemoteDs {

  Future<List<Model>> searchDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });
}