import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order%20track/data/model/confirm_order/confirm_order.dart';
import 'package:chefaa/features/patient/order%20track/domain/repository/order_track_repo.dart';
import 'package:dartz/dartz.dart';

class ConfirmOrderUsecase {
  final OrderTrackRepo repo;

  ConfirmOrderUsecase({required this.repo});

  Future<Either<ErrorModel, ConfirmOrder>> call({
    required String orderId,
  }) async {
    return await repo.orderConfirm(orderId: orderId);
  }
}
