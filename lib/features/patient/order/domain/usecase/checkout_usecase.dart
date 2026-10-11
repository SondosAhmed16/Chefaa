import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order/data/model/order_model/order_model.dart';
import 'package:chefaa/features/patient/order/domain/entity/order_request.dart';
import 'package:chefaa/features/patient/order/domain/repository/checkout_repo.dart';
import 'package:dartz/dartz.dart';

class CheckoutUsecase {
  final CheckoutRepo repo;

  CheckoutUsecase({required this.repo});

  Future<Either<ErrorModel, OrderModel>> call({
    required OrderRequestModel orderRequest,
  }) async {
    return await repo.createOrder(orderRequest: orderRequest);
  }
}
