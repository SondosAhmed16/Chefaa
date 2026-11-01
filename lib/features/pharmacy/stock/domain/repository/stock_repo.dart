import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/add_medicine_model/add_medicine_model.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/get_stock_model/get_stock_model.dart';
import 'package:dartz/dartz.dart';

abstract class StockRepo {
  Future<Either<ErrorModel, AddMedicineModel>> addMed({
    required Map<String, dynamic> body,
  });
  Future<Either<ErrorModel, GetStockModel>> getMed({String? filter});
  Future<Either<ErrorModel, AddMedicineModel>> restock({
    required String medId,
    required Map<String, dynamic> body,
  });
}
