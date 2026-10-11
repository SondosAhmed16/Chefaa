import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order%20track/data/model/confirm_order/confirm_order.dart';
import 'package:chefaa/features/patient/order%20track/data/model/order_track_model.dart';
import 'package:dartz/dartz.dart';

abstract class OrderTrackRepo {
  Future<Either<ErrorModel, OrderTrackModel>> orderTrack({
    required String orderId,
  });

  Future<Either<ErrorModel, ConfirmOrder>> orderConfirm({
    required String orderId,
  });
}
