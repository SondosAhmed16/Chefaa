import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order/data/model/get_orders/get_orders.dart';
import 'package:chefaa/features/patient/order/domain/repository/checkout_repo.dart';
import 'package:dartz/dartz.dart';

class GetOrdersUsecase {
  final CheckoutRepo repo;

  GetOrdersUsecase({required this.repo});

  Future<Either<ErrorModel, GetOrders>> call() async {
    return await repo.getOrder();
  }
}
