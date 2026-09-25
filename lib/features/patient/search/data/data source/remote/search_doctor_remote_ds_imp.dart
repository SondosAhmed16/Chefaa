import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/search/data/data%20source/remote/search_doctor_remote_ds.dart';
import 'package:chefaa/features/patient/search/data/model/model.dart';

class SearchDoctorRemoteDsImp implements SearchDoctorRemoteDs {
  final ApiConsumer api;

  SearchDoctorRemoteDsImp({required this.api});

  @override
  Future<List<Model>> searchDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    final Map<String, dynamic> queryParams = {};

    if (searchText != null && searchText.trim().isNotEmpty) {
      queryParams['name'] = searchText.trim();
    }
    if (specialization != null && specialization.trim().isNotEmpty) {
      queryParams['specialization'] = specialization.trim();
    }
    if (gender != null && gender.trim().isNotEmpty) {
      queryParams['gender'] = gender.trim();
    }
    if (location != null && location.trim().isNotEmpty) {
      queryParams['location'] = location.trim();
    }

    final response = await api.get(
      ApiEndpoints.searchDoctor,
      queryParam: queryParams,
    );

    final List<dynamic> listData = response as List<dynamic>;
    return listData
        .map((e) => Model.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
