import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/book/data/model/slot.dart';
import 'package:chefaa/features/patient/book/domain/repository/book_appo_repo.dart';
import 'package:dartz/dartz.dart';

class GetSlotsUsecase {
  final BookAppoRepo repo;

  GetSlotsUsecase({required this.repo});

  Future<Either<ErrorModel, List<Slot>>> call({
    required String clinicId,
    required String date,
  }) async {
    return repo.getSlots(clinicId: clinicId, date: date);
  }
}
