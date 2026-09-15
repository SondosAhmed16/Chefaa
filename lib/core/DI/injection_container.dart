import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/dio_consumer.dart';
import 'package:chefaa/features/auth/data/dataSource/data_source.dart';
import 'package:chefaa/features/auth/data/dataSource/data_source_implement.dart';
import 'package:chefaa/features/auth/data/repository/auth_repository_implement.dart';
import 'package:chefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:chefaa/features/auth/domain/useCases/login_usecase.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  
  
  void _initAuthModule() {
  getIt.registerLazySingleton<DataSource>(
    () => DataSourceImplement(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplement(dataSource: getIt<DataSource>()),
  );
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(loginUsecase: getIt<LoginUsecase>()),
  );
  }
  
  // Features - Auth
  _initAuthModule();
  }