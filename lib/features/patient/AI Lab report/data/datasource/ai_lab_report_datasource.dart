import 'dart:io';

import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/data.dart';

abstract class AiLabReportDatasource {

Future<Data> analyzeReport({required File labReport});


}