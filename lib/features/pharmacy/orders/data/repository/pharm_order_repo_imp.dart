import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/pharmacy/orders/data/datasource/pharm_order_datasource.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/get_orders_model/get_orders_model.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/order_stat_model/order_stat_model.dart';
import 'package:chefaa/features/pharmacy/orders/domain/repository/pharm_order_repo.dart';
import 'package:dartz/dartz.dart';

class PharmOrderRepoImp implements PharmOrderRepo {
  final PharmOrderDatasource datasource;

  PharmOrderRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, OrderStatModel>> acceptOrder({
    required String orderId,
  }) async {
    try {
      final response = await datasource.acceptOrder(orderId: orderId);
      final model = OrderStatModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, OrderStatModel>> completeOrder({
    required String orderId,
  }) async {
    try {
      final response = await datasource.completeOrder(orderId: orderId);
      final model = OrderStatModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, GetOrdersModel>> getOrders({String? status}) async {
    try {
      final response = await datasource.getOrders(status: status);
      final model = GetOrdersModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, OrderStatModel>> readyOrder({
    required String orderId,
  }) async {
    try {
      final response = await datasource.readyOrder(orderId: orderId);
      final model = OrderStatModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
