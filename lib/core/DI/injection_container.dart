import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/dio_consumer.dart';

import 'package:chefaa/features/auth/data/dataSource/data_source.dart';
import 'package:chefaa/features/auth/data/dataSource/data_source_implement.dart';
import 'package:chefaa/features/auth/data/repository/auth_repository_implement.dart';
import 'package:chefaa/features/auth/domain/repository/auth_repository.dart';
import 'package:chefaa/features/auth/domain/useCases/forget_password_usecase.dart';
import 'package:chefaa/features/auth/domain/useCases/login_usecase.dart';
import 'package:chefaa/features/auth/domain/useCases/reset_password_usecase.dart';
import 'package:chefaa/features/auth/domain/useCases/verify_code_usecase.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth.dart';
import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth_implement.dart';
import 'package:chefaa/features/patient/auth/data/repository/register_patient_repository_implement.dart';
import 'package:chefaa/features/patient/auth/domain/repository/register_patient_reopsitory.dart';
import 'package:chefaa/features/patient/auth/domain/usecases/register_patient_usecase.dart';
import 'package:chefaa/features/patient/auth/presentation/cubit/patient_auth_cubit.dart'; // 👈 Import PatientAuthCubit

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // Core
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  // Features - Auth
  _initAuthModule();
  _initAuthModulePatient();
}

void _initAuthModule() {
  // Data Sources
  getIt.registerLazySingleton<DataSource>(
    () => DataSourceImplement(apiConsumer: getIt<ApiConsumer>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplement(dataSource: getIt<DataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ForgetPasswordUsecase>(
    () => ForgetPasswordUsecase(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<VerifyCodeUsecase>(
    () => VerifyCodeUsecase(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ResetPasswordUsecase>(
    () => ResetPasswordUsecase(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUsecase: getIt<LoginUsecase>(),
      forgetPasswordUsecase: getIt<ForgetPasswordUsecase>(),
      verifyCodeUsecase: getIt<VerifyCodeUsecase>(),
      resetPasswordUsecase: getIt<ResetPasswordUsecase>(),
    ),
  );
}

void _initAuthModulePatient() {
  // Data Sources
  getIt.registerLazySingleton<DataSourcePatientAuth>(
    () => DataSourcePatientAuthImplement(apiConsumer: getIt<ApiConsumer>()),
  );

  // Repositories
  getIt.registerLazySingleton<RegisterPatientReopsitory>(
    () => RegisterPatientRepositoryImplement(
      dataSource: getIt<DataSourcePatientAuth>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<RegisterPatientUsecase>(
    () => RegisterPatientUsecase(
      registerPatientReopsitory: getIt<RegisterPatientReopsitory>(),
    ),
  );

  getIt.registerFactory<PatientAuthCubit>(
    () => PatientAuthCubit(
      registerPatientUsecase: getIt<RegisterPatientUsecase>(),
    ),
  );
}
