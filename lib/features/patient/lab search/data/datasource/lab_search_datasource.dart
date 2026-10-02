import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';

abstract class LabSearchDatasource {
  Future<List<CenterModel>> searchLab({String? requiredServices, bool? homeService});
}
