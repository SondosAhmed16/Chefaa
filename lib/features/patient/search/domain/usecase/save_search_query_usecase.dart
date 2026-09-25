import 'package:chefaa/features/patient/search/domain/repository/search_doctor_repo.dart';

class SaveSearchQueryUseCase {
  final SearchDoctorRepo repo;
  SaveSearchQueryUseCase(this.repo);

  Future<void> call(String query) async {
    if (query.trim().isEmpty) return;
    await repo.saveSearchQuery(query.trim());
  }

  
}