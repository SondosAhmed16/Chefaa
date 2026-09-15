import 'package:chefaa/features/auth/data/model/login_response_model.dart';


abstract class DataSource {

  Future<LoginResponseModel> login({required String identity , required String password})
;}