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
import 'package:chefaa/features/doctor/auth/data/data%20source/data_source_doctor_auth.dart';
import 'package:chefaa/features/doctor/auth/data/data%20source/data_source_doctor_auth_implement.dart';
import 'package:chefaa/features/doctor/auth/data/repository/register_doctor_repository_implement.dart';
import 'package:chefaa/features/doctor/auth/domain/repository/register_doctor_reopsitory.dart';
import 'package:chefaa/features/doctor/auth/domain/usecases/register_doctor_usecase.dart';
import 'package:chefaa/features/doctor/auth/presentation/cubit/doctor_auth_cubit.dart';
import 'package:chefaa/features/facility/auth/data/data%20source/facilitu_auth_datasource_imp.dart';
import 'package:chefaa/features/facility/auth/data/data%20source/facility_auth_datasource.dart';
import 'package:chefaa/features/facility/auth/data/repositiry/facility_auth_repo_imp.dart';
import 'package:chefaa/features/facility/auth/domain/repository/facility_register_repo.dart';
import 'package:chefaa/features/facility/auth/domain/usecase/faciclity_usecase_register.dart';
import 'package:chefaa/features/facility/auth/presentation/cubit/facility_auth_cubit.dart';

import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth.dart';
import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth_implement.dart';
import 'package:chefaa/features/patient/auth/data/repository/register_patient_repository_implement.dart';
import 'package:chefaa/features/patient/auth/domain/repository/register_patient_reopsitory.dart';
import 'package:chefaa/features/patient/auth/domain/usecases/register_patient_usecase.dart';
import 'package:chefaa/features/patient/auth/presentation/cubit/patient_auth_cubit.dart';
import 'package:chefaa/features/pharmacy/auth/data/data%20source/data_source_pharmacy_auth.dart';
import 'package:chefaa/features/pharmacy/auth/data/data%20source/data_source_pharmacy_auth_implement.dart';
import 'package:chefaa/features/pharmacy/auth/data/repository/register_pharmacy_repository_implement.dart';
import 'package:chefaa/features/pharmacy/auth/domain/repository/register_pharmacy_reopsitory.dart';
import 'package:chefaa/features/pharmacy/auth/domain/usecases/register_pharmacy_usecase.dart';
import 'package:chefaa/features/pharmacy/auth/presentation/cubit/pharmacy_auth_cubit.dart';

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
  _initAuthModuleDoctor();
  _initAuthModulePharmacy();
  _initAuthModuleFacility();
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

void _initAuthModuleDoctor() {
  // Data Sources
  getIt.registerLazySingleton<DataSourceDoctorAuth>(
    () => DataSourceDoctorAuthImplement(apiConsumer: getIt<ApiConsumer>()),
  );

  // Repositories
  getIt.registerLazySingleton<RegisterDoctorReopsitory>(
    () => RegisterDoctorRepositoryImplement(
      dataSource: getIt<DataSourceDoctorAuth>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<RegisterDoctorUsecase>(
    () => RegisterDoctorUsecase(
      registerDoctorReopsitory: getIt<RegisterDoctorReopsitory>(),
    ),
  );

  getIt.registerFactory<DoctorAuthCubit>(
    () =>
        DoctorAuthCubit(registerDoctorUsecase: getIt<RegisterDoctorUsecase>()),
  );
}

void _initAuthModulePharmacy() {
  // Data Sources
  getIt.registerLazySingleton<DataSourcePharmacyAuth>(
    () => DataSourcePharmacyAuthImplement(apiConsumer: getIt<ApiConsumer>()),
  );

  // Repositories
  getIt.registerLazySingleton<RegisterPharmacyReopsitory>(
    () => RegisterPharmacyRepositoryImplement(
      dataSource: getIt<DataSourcePharmacyAuth>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<RegisterPharmacyUsecase>(
    () => RegisterPharmacyUsecase(
      registerPharmacyReopsitory: getIt<RegisterPharmacyReopsitory>(),
    ),
  );

  getIt.registerFactory<PharmacyAuthCubit>(
    () => PharmacyAuthCubit(
      registerPharmacyUsecase: getIt<RegisterPharmacyUsecase>(),
    ),
  );
}

void _initAuthModuleFacility() {
  // Data Sources
  getIt.registerLazySingleton<FacilityAuthDatasource>(
    () => FacilituAuthDatasourceImp(apiConsumer: getIt<ApiConsumer>()),
  );

  // Repositories
  getIt.registerLazySingleton<FacilityRegisterRepo>(
    () => FacilityAuthRepoImp(
      facilityAuthDatasource: getIt<FacilityAuthDatasource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<FaciclityUsecaseRegister>(
    () => FaciclityUsecaseRegister(
      facilityRegisterRepo: getIt<FacilityRegisterRepo>(),
    ),
  );

  getIt.registerFactory<FacilityAuthCubit>(
    () => FacilityAuthCubit(useCase: getIt<FaciclityUsecaseRegister>()),
  );
}
