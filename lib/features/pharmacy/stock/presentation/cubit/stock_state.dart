import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/add_medicine_model/add_medicine_model.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/get_stock_model/get_stock_model.dart';

sealed class StockState {}

class StockInitial extends StockState {}

class GetStockLoading extends StockState {}

class GetStockSuccess extends StockState {
  final GetStockModel getStockModel;
  GetStockSuccess({required this.getStockModel});
}

class GetStockFailure extends StockState {
  final ErrorModel errorModel;
  GetStockFailure({required this.errorModel});
}

class AddMedicineLoading extends StockState {}

class AddMedicineSuccess extends StockState {
  final AddMedicineModel addMedicineModel;
  AddMedicineSuccess({required this.addMedicineModel});
}

class AddMedicineFailure extends StockState {
  final ErrorModel errorModel;
  AddMedicineFailure({required this.errorModel});
}

class RestockLoading extends StockState {}

class RestockSuccess extends StockState {
  final AddMedicineModel model;
  RestockSuccess({required this.model});
}

class RestockFailure extends StockState {
  final ErrorModel errorModel;
  RestockFailure({required this.errorModel});
}
