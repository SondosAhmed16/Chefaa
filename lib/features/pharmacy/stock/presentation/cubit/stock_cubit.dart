import 'package:bloc/bloc.dart';
import 'package:chefaa/features/pharmacy/stock/domain/repository/stock_repo.dart';
import 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final StockRepo repo;

  StockCubit({required this.repo}) : super(StockInitial());

  Future<void> getStock({String? filter}) async {
    emit(GetStockLoading());
    final result = await repo.getMed(filter: filter);
    result.fold(
      (error) => emit(GetStockFailure(errorModel: error)),
      (model) => emit(GetStockSuccess(getStockModel: model)),
    );
  }

  Future<void> addMedicine({
    required Map<String, dynamic> body,
    String? filter,
  }) async {
    emit(AddMedicineLoading());
    final result = await repo.addMed(body: body);

    result.fold((error) => emit(AddMedicineFailure(errorModel: error)), (
      model,
    ) async {
      emit(AddMedicineSuccess(addMedicineModel: model));
      await getStock(filter: filter);
    });
  }

  Future<void> restock({
    required String medId,
    required Map<String, dynamic> body,
    String? filter,
  }) async {
    emit(RestockLoading());
    final result = await repo.restock(medId: medId, body: body);

    result.fold((error) => emit(RestockFailure(errorModel: error)), (
      model,
    ) async {
      emit(RestockSuccess(model: model));
      await getStock(filter: filter);
    });
  }
}
