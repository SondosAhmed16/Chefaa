import 'package:chefaa/features/patient/lab%20search/domain/usecase/lab_search_usecase.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/cubit/lab_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabSearchCubit extends Cubit<LabSearchState> {
  final LabSearchUsecase usecase;

  LabSearchCubit({required this.usecase}) : super(LabSearchInitialState());

  Future<void> serachLAb({String? requiredServices, bool? homeService}) async {
    if (!isClosed) emit(LabSearchLoadingState());
    final result = await usecase.call(
      requiredServices: requiredServices,
      homeService: homeService,
    );

    result.fold(
      (error) => emit(LabSearchErrorState(error)),
      (centers) => emit(LabSearchSuccessState(centers: centers)),
    );
  }
}
