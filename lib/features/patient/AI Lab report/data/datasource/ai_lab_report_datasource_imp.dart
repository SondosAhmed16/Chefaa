import 'dart:io';

import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/datasource/ai_lab_report_datasource.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/ai_lab_report.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/data.dart';
import 'package:dio/dio.dart';

class AiLabReportDatasourceImp implements AiLabReportDatasource {
  final ApiConsumer api;

  AiLabReportDatasourceImp({required this.api});

  @override
  Future<Data> analyzeReport({required File labReport}) async {
    final response = await api.post(
      ApiEndpoints.analyzeLabReport,
      isFormated: true,
      data: {
        "labReport": await MultipartFile.fromFile(
          labReport.path,
          filename: labReport.path.split('/').last,
        ),
      },
    );

    final report = AiLabReport.fromMap(response as Map<String, dynamic>);
    if (report.data != null) {
      return report.data!;
    } else {
      throw Exception('Failed to parse lab report data');
    }
  }
}
