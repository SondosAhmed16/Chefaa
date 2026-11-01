import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/get_orders_model/get_orders_model.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/order_stat_model/order_stat_model.dart';
import 'package:dartz/dartz.dart';

abstract class PharmOrderRepo {
  Future<Either<ErrorModel, GetOrdersModel>> getOrders({String? status});
  Future<Either<ErrorModel, OrderStatModel>> acceptOrder({
    required String orderId,
  });
  Future<Either<ErrorModel, OrderStatModel>> readyOrder({
    required String orderId,
  });
  Future<Either<ErrorModel, OrderStatModel>> completeOrder({
    required String orderId,
  });
}
