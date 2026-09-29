import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/features/patient/search/domain/repository/search_doctor_repo.dart';
import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_state.dart';

class SearchDoctorCubit extends Cubit<SearchDoctorState> {
  final SearchDoctorRepo searchDoctorRepo;

  SearchDoctorCubit({required this.searchDoctorRepo})
    : super(SearchDoctorInitialState());

  static SearchDoctorCubit get(context) => BlocProvider.of(context);

  List<String> searchHistory = [];

  Future<void> searchDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    emit(SearchDoctorLoadingState());

    final result = await searchDoctorRepo.searchDoctors(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );

    result.fold(
      (error) => emit(SearchDoctorErrorState(error)),
      (doctors) => emit(SearchDoctorSuccessState(doctors)),
    );
  }

  Future<void> getSearchHistory() async {
    final result = await searchDoctorRepo.getSearchHistory();

    result.fold(
      (error) {
        searchHistory = [];
        emit(SearchHistoryLoadedState(const []));
      },
      (historyList) {
        searchHistory = historyList;
        emit(SearchHistoryLoadedState(historyList));
      },
    );
  }

  Future<void> deleteSearchQuery(String query) async {
    final result = await searchDoctorRepo.deleteSearchQuery(query);

    result.fold(
      (error) => emit(SearchHistoryErrorState(error)),
      (_) => getSearchHistory(),
    );
  }

  Future<void> clearSearchHistory() async {
    final result = await searchDoctorRepo.clearSearchHistory();

    result.fold(
      (error) => emit(SearchHistoryErrorState(error)),
      (_) => getSearchHistory(),
    );
  }

  void resetSearch() {
    emit(SearchDoctorInitialState());
  }

  Future<void> saveSearchQuery(String query) async {
    if (query.trim().isEmpty) return;
    await searchDoctorRepo.saveSearchQuery(query);
    await getSearchHistory();
  }
}
