import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/auth/data/dataSource/data_source.dart';
import 'package:chefaa/features/auth/data/model/login_response_model.dart';


class DataSourceImplement implements DataSource {
  final ApiConsumer apiConsumer;

  DataSourceImplement({required this.apiConsumer});
  @override
  Future<LoginResponseModel> login({
    required String identity,
    required String password,
  }) async {
    final response = await apiConsumer.post(
      ApiEndpoints.login,
      data: {"identity": identity, "password": password},
    );
    return LoginResponseModel.fromJson(response);
  }
}
