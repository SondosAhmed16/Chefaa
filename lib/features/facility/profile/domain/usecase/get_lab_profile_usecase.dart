import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/profile/data/model/lab_profile_response.dart';
import 'package:chefaa/features/facility/profile/domain/repository/lab_profile_repo.dart';
import 'package:dartz/dartz.dart';

class GetLabProfileUsecase {
  final LabProfileRepo repo;

  GetLabProfileUsecase({required this.repo});

  Future<Either<ErrorModel, LabProfileResponse>> call() async {
    return await repo.getLabProfile();
  }
}
