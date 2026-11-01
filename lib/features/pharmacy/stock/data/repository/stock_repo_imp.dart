import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/pharmacy/stock/data/datasource/stock_datasource.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/add_medicine_model/add_medicine_model.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/get_stock_model/get_stock_model.dart';
import 'package:chefaa/features/pharmacy/stock/domain/repository/stock_repo.dart';
import 'package:dartz/dartz.dart';

class StockRepoImp implements StockRepo {
  final StockDatasource datasource;

  StockRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, AddMedicineModel>> addMed({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await datasource.addMed(body: body);
      final model = AddMedicineModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, GetStockModel>> getMed({String? filter}) async {
    try {
      final response = await datasource.getMed(filter: filter);
      final model = GetStockModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, AddMedicineModel>> restock({
    required String medId,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await datasource.restock(medId: medId, body: body);
      final model = AddMedicineModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
