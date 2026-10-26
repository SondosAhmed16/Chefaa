import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/doctor/brief/data/datasource/doctor_brief_datasource.dart';

class DoctorBriefDatasourceImo implements DoctorBriefDatasource {
  final ApiConsumer api;

  DoctorBriefDatasourceImo({required this.api});

  @override
  Future<dynamic> getDoctorBrief() async {
    return await api.get(
      ApiEndpoints.doctorBrief,
      queryParam: {"lang": "english"},
    );
  }


}
