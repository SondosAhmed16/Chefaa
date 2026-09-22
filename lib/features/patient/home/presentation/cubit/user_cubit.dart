import 'package:chefaa/core/services/storage_services.dart';
import 'package:chefaa/core/shared%20classes/user_entity.dart';
import 'package:chefaa/features/patient/home/domain/use%20cases/user_usecase.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserUseCase _userUseCase;

  UsersCubit(this._userUseCase) : super(UsersInitial());

  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> setUser(UserEntity user) async {
    await StorageServices.saveUser(user);
    if (!isClosed) emit(UserLoaded(user: user));
  }

  Future<void> loadUserFromPrefs() async {
    if (!isClosed) emit(UsersLoading());

    try {
      final user = await StorageServices.getUser();

      if (user != null && user.name.isNotEmpty) {
        if (!isClosed) emit(UserLoaded(user: user));
      } else {
        if (!isClosed) emit(UsersError(error: "User not found"));
      }
    } catch (e) {
      if (!isClosed) emit(UsersError(error: e.toString()));
    }
  }

  Future<void> logout() async {
    await StorageServices.logout();
    if (!isClosed) emit(UserLoggedOut());
  }

  Future<void> getAppointments() async {}
}
