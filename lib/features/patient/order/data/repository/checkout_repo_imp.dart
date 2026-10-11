import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/order/data/datasource/checkout_datasource.dart';
import 'package:chefaa/features/patient/order/data/model/get_orders/get_orders.dart';
import 'package:chefaa/features/patient/order/data/model/order_model/order_model.dart';
import 'package:chefaa/features/patient/order/domain/entity/order_request.dart';
import 'package:chefaa/features/patient/order/domain/repository/checkout_repo.dart';
import 'package:dartz/dartz.dart';

class CheckoutRepoImp implements CheckoutRepo {
  final CheckoutDatasource datasource;

  CheckoutRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, OrderModel>> createOrder({
    required OrderRequestModel orderRequest,
  }) async {
    try {
      final response = await datasource.createOrder(orderRequest: orderRequest);
      final model = OrderModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, GetOrders>> getOrder() async {
    try {
      final response = await datasource.getOrders();
      final model = GetOrders.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
