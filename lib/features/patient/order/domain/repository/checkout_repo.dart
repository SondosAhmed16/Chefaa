import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order/data/model/get_orders/get_orders.dart';
import 'package:chefaa/features/patient/order/data/model/order_model/order_model.dart';
import 'package:chefaa/features/patient/order/domain/entity/order_request.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepo {
  Future<Either<ErrorModel, OrderModel>> createOrder({
    required OrderRequestModel orderRequest,
  });
  Future<Either<ErrorModel, GetOrders>> getOrder();
}
