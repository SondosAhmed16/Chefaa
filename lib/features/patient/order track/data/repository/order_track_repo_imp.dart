import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/order%20track/data/datasource/order_track_datasource.dart';
import 'package:chefaa/features/patient/order%20track/data/model/confirm_order/confirm_order.dart';
import 'package:chefaa/features/patient/order%20track/data/model/order_track_model.dart';
import 'package:chefaa/features/patient/order%20track/domain/repository/order_track_repo.dart';
import 'package:dartz/dartz.dart';

class OrderTrackRepoImp implements OrderTrackRepo {
  final OrderTrackDatasource datasource;

  OrderTrackRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, OrderTrackModel>> orderTrack({
    required String orderId,
  }) async {
    try {
      final response = await datasource.orderTrack(orderId: orderId);
      final model = OrderTrackModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ConfirmOrder>> orderConfirm({
    required String orderId,
  }) async {
    try {
      final response = await datasource.orderConfirm(orderId: orderId);
      final model = ConfirmOrder.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
