import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';

abstract class LabResultDatasource {
  Future<List<Result>> getLabResults();
}
