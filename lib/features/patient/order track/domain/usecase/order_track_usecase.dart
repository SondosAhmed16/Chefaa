import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order%20track/data/model/order_track_model.dart';
import 'package:chefaa/features/patient/order%20track/domain/repository/order_track_repo.dart';
import 'package:dartz/dartz.dart';

class OrderTrackUsecase {
  final OrderTrackRepo repo;

  OrderTrackUsecase({required this.repo});

  Future<Either<ErrorModel, OrderTrackModel>> call({
    required String orderId,
  }) async {
    return await repo.orderTrack(orderId: orderId);
  }
}
