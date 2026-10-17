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
import 'package:chefaa/features/facility/dashboard/data/datasource/lab_dashboard_datasource.dart';
import 'package:chefaa/features/facility/dashboard/data/datasource/lab_dashboard_datasource_imp.dart';
import 'package:chefaa/features/facility/dashboard/data/repository/lab_dashboard_repo_imp.dart';
import 'package:chefaa/features/facility/dashboard/domain/repository/lab_dashboard_repo.dart';
import 'package:chefaa/features/facility/dashboard/domain/usecase/get_lab_dashboard_usecase.dart';
import 'package:chefaa/features/facility/dashboard/presentation/cubit/lab_dashboard_cubit.dart';
import 'package:chefaa/features/facility/profile/data/datasource/lab_profile_datasource.dart';
import 'package:chefaa/features/facility/profile/data/datasource/lab_profile_datasource_imp.dart';
import 'package:chefaa/features/facility/profile/data/repository/lab_profile_repo_imp.dart';
import 'package:chefaa/features/facility/profile/domain/repository/lab_profile_repo.dart';
import 'package:chefaa/features/facility/profile/domain/usecase/get_lab_profile_usecase.dart';
import 'package:chefaa/features/facility/profile/domain/usecase/update_lab_profile_usecase.dart';
import 'package:chefaa/features/facility/profile/presentation/cubit/lab_profile_cubit.dart';
import 'package:chefaa/features/facility/services/data/datasource/lab_services_datasource.dart';
import 'package:chefaa/features/facility/services/data/datasource/lab_services_datasource_imp.dart';
import 'package:chefaa/features/facility/services/data/repository/lab_services_repo_imp.dart';
import 'package:chefaa/features/facility/services/domain/repository/lab_services_repo.dart';
import 'package:chefaa/features/facility/services/domain/usecase/get_center_services_usecase.dart';
import 'package:chefaa/features/facility/services/domain/usecase/toggle_service_usecase.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_cubit.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/datasource/ai_lab_report_datasource.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/datasource/ai_lab_report_datasource_imp.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/repository/lab_report_repo_imp.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/domain/repository/lab_report_repo.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/domain/usecase/analyze_report_usecase.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/cubit/ai_report_cubit.dart';
import 'package:chefaa/features/patient/appointment/data/data%20source/appointment_datasource.dart';
import 'package:chefaa/features/patient/appointment/data/data%20source/appointment_datasourcse_imp.dart';
import 'package:chefaa/features/patient/appointment/data/repository/appointment_repo_imp.dart';
import 'package:chefaa/features/patient/appointment/domain/repository/appointment_repo.dart';
import 'package:chefaa/features/patient/appointment/domain/use%20cases/cancel_appointment_usecase.dart';
import 'package:chefaa/features/patient/appointment/domain/use%20cases/get_patient_appo.dart';
import 'package:chefaa/features/patient/appointment/domain/use%20cases/reschedual_appo_usecase.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth.dart';
import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth_implement.dart';
import 'package:chefaa/features/patient/auth/data/repository/register_patient_repository_implement.dart';
import 'package:chefaa/features/patient/auth/domain/repository/register_patient_reopsitory.dart';
import 'package:chefaa/features/patient/auth/domain/usecases/register_patient_usecase.dart';
import 'package:chefaa/features/patient/auth/presentation/cubit/patient_auth_cubit.dart';
import 'package:chefaa/features/patient/book/data/data%20source/book_appo_datasourcde_imp.dart';
import 'package:chefaa/features/patient/book/data/data%20source/book_appo_datasource.dart';
import 'package:chefaa/features/patient/book/data/repository/book_appo_repo_imp.dart';
import 'package:chefaa/features/patient/book/domain/repository/book_appo_repo.dart';
import 'package:chefaa/features/patient/book/domain/usecase/book_appo_usecase.dart';
import 'package:chefaa/features/patient/book/domain/usecase/get_slots_usecase.dart';
import 'package:chefaa/features/patient/book/domain/usecase/gwt_doctor_clinic_usecase.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_cubit.dart';
import 'package:chefaa/features/patient/cart/presentation/cubit/cart_cubit.dart';
import 'package:chefaa/features/patient/chatbot/data/datasource/chatbot_patient_datasource.dart';
import 'package:chefaa/features/patient/chatbot/data/datasource/chatbot_patient_datasource_imp.dart';
import 'package:chefaa/features/patient/chatbot/data/repository/chatbot_patient_repo_imp.dart';
import 'package:chefaa/features/patient/chatbot/domain/repository/chatbot_patient_repo.dart';
import 'package:chefaa/features/patient/chatbot/domain/usecase/chatbot_patient_usecase.dart';
import 'package:chefaa/features/patient/chatbot/presentation/cubit/chatbot_patient_cubit.dart';
import 'package:chefaa/features/patient/home/domain/use%20cases/user_usecase.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_cubit.dart';
import 'package:chefaa/features/patient/lab%20results/data/datasource/lab_result_datasource.dart';
import 'package:chefaa/features/patient/lab%20results/data/datasource/lab_result_datasource_imp.dart';
import 'package:chefaa/features/patient/lab%20results/data/repository/lab_result_repo_imp.dart';
import 'package:chefaa/features/patient/lab%20results/domain/repository/lab_result_repo.dart';
import 'package:chefaa/features/patient/lab%20results/domain/usecase/get_lab_results_usecase.dart';
import 'package:chefaa/features/patient/lab%20results/presentation/cubit/lab_result_cubit.dart';
import 'package:chefaa/features/patient/lab%20search/data/datasource/lab_search_datasource.dart';
import 'package:chefaa/features/patient/lab%20search/data/datasource/lab_search_datasource_imp.dart';
import 'package:chefaa/features/patient/lab%20search/data/repository/search_lab_repo_imp.dart';
import 'package:chefaa/features/patient/lab%20search/domain/repository/search_lab_repo.dart';
import 'package:chefaa/features/patient/lab%20search/domain/usecase/lab_search_usecase.dart';
import 'package:chefaa/features/patient/lab%20search/presentation/cubit/lab_search_cubit.dart';
import 'package:chefaa/features/patient/medication/data/data%20source/medication_datasource_imp.dart';
import 'package:chefaa/features/patient/medication/data/data%20source/medication_datasourcse.dart';
import 'package:chefaa/features/patient/medication/data/repository/medication_repo_imp.dart';
import 'package:chefaa/features/patient/medication/domain/repository/medication_repo.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_cubit.dart';
import 'package:chefaa/features/patient/notification/data/data%20source/notification_datasource.dart';
import 'package:chefaa/features/patient/notification/data/data%20source/notification_datasourcse_imp.dart';
import 'package:chefaa/features/patient/notification/data/repository/notification_repo_imp.dart';
import 'package:chefaa/features/patient/notification/domain/repository/notification_repo.dart';
import 'package:chefaa/features/patient/notification/domain/usecase/get_notification_usecase.dart';
import 'package:chefaa/features/patient/notification/presentation/cubit/notification_cubit.dart';
import 'package:chefaa/features/patient/onboarding/data/data%20source/patient_all_info_datasource.dart';
import 'package:chefaa/features/patient/onboarding/data/data%20source/patient_all_info_datasource_imp.dart';
import 'package:chefaa/features/patient/onboarding/data/repository/patient_all_info_repo_imp.dart';
import 'package:chefaa/features/patient/onboarding/domain/repository/patient_all_info_repo.dart';
import 'package:chefaa/features/patient/onboarding/domain/usecase/patient_all_info_usacse.dart';
import 'package:chefaa/features/patient/onboarding/presentation/cubit/all_info_cubit.dart';
import 'package:chefaa/features/patient/order%20track/data/datasource/order_track_datasource.dart';
import 'package:chefaa/features/patient/order%20track/data/datasource/order_track_datasource_imp.dart';
import 'package:chefaa/features/patient/order%20track/data/repository/order_track_repo_imp.dart';
import 'package:chefaa/features/patient/order%20track/domain/repository/order_track_repo.dart';
import 'package:chefaa/features/patient/order%20track/domain/usecase/confirm_order_usecase.dart';
import 'package:chefaa/features/patient/order%20track/domain/usecase/order_track_usecase.dart';
import 'package:chefaa/features/patient/order%20track/presentation/cubit/order_track_cubit.dart';
import 'package:chefaa/features/patient/order/data/datasource/checkout_datasource.dart';
import 'package:chefaa/features/patient/order/data/datasource/checkout_datasource_imp.dart';
import 'package:chefaa/features/patient/order/data/repository/checkout_repo_imp.dart';
import 'package:chefaa/features/patient/order/domain/repository/checkout_repo.dart';
import 'package:chefaa/features/patient/order/domain/usecase/checkout_usecase.dart';
import 'package:chefaa/features/patient/order/domain/usecase/get_orders_usecase.dart';
import 'package:chefaa/features/patient/order/presentation/cubit/checkout_cubit.dart';
import 'package:chefaa/features/patient/order/presentation/cubit/get_orders_cubit.dart';
import 'package:chefaa/features/patient/payment/data/datasource/payment_datasource.dart';
import 'package:chefaa/features/patient/payment/data/datasource/payment_online_imp.dart';
import 'package:chefaa/features/patient/payment/data/repository/payment_repo_imp.dart';
import 'package:chefaa/features/patient/payment/domain/repository/payment_repo.dart';
import 'package:chefaa/features/patient/payment/domain/usecase/payment_online_usecase.dart';
import 'package:chefaa/features/patient/payment/presentation/cubit/payment_cubit.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/datasource/pharmacy_search_datasource.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/datasource/pharmacy_search_datasource_imp.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/repository/pharmacy_search_repo_imp.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/repository/pharmacy_search_repo.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/get_medicine_details_usecase.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/get_pharmacy_medicines_usecase.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/get_pharmacy_profile.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/usecase/pharmacy_search_usecase.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/cubit/pharmacy_search_cubit.dart';
import 'package:chefaa/features/patient/profile/data/data%20source/patient_profile_data_source.dart';
import 'package:chefaa/features/patient/profile/data/data%20source/patient_profile_data_source_imp.dart';
import 'package:chefaa/features/patient/profile/data/repository/patient_profile_repo_imp.dart';
import 'package:chefaa/features/patient/profile/domain/repository/patient_profile_repo.dart';
import 'package:chefaa/features/patient/profile/domain/usecase/get_profile_usecase.dart';
import 'package:chefaa/features/patient/profile/domain/usecase/update_basic_info_usecase.dart';
import 'package:chefaa/features/patient/profile/domain/usecase/update_med_info_usecase.dart';
import 'package:chefaa/features/patient/profile/presentation/cubit/profile_patient_cubit.dart';
import 'package:chefaa/features/patient/search/data/data%20source/local/search_doctor_local_ds.dart';
import 'package:chefaa/features/patient/search/data/data%20source/local/search_doctor_local_ds_imp.dart';
import 'package:chefaa/features/patient/search/data/data%20source/remote/search_doctor_remote_ds.dart';
import 'package:chefaa/features/patient/search/data/data%20source/remote/search_doctor_remote_ds_imp.dart';
import 'package:chefaa/features/patient/search/data/repository/search_doctor_repo_imp.dart';
import 'package:chefaa/features/patient/search/domain/repository/search_doctor_repo.dart';
import 'package:chefaa/features/patient/search/presentation/cubit/search_doctor_cubit.dart';
import 'package:chefaa/features/pharmacy/auth/data/data%20source/data_source_pharmacy_auth.dart';
import 'package:chefaa/features/pharmacy/auth/data/data%20source/data_source_pharmacy_auth_implement.dart';
import 'package:chefaa/features/pharmacy/auth/data/repository/register_pharmacy_repository_implement.dart';
import 'package:chefaa/features/pharmacy/auth/domain/repository/register_pharmacy_reopsitory.dart';
import 'package:chefaa/features/pharmacy/auth/domain/usecases/register_pharmacy_usecase.dart';
import 'package:chefaa/features/pharmacy/auth/presentation/cubit/pharmacy_auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // Core
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  _initAuthModule();
  _initAuthModulePatient();
  _initAuthModuleDoctor();
  _initAuthModulePharmacy();
  _initAuthModuleFacility();
  _initPatientOnboardingInfoModule();
  _initPatientProfileModule();
  _initPatientMedicationModule();
  _initPatientHomeModule();
  _initPatientAppointmentModule();
  _initPatientNotificationModule();
  _initPatientSearchModule();
  _initBookAppointment();
  _initFindLabModule();
  _initGetLabResultModule();
  _initAnalzeLabResultModule();
  _initChatbotPatientModule();
  _initSearchPharmacyModule();
  _initCartModule();
  _initCheckoutModule();
  _initPaymentModule();
  _initOrderTrackModule();
  _initGetOrdersModule();
  _initLabProfileModule();
  _initLabServicesModule();
  _initLabDashboardModule();
}

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
  getIt.registerLazySingleton<DataSourcePatientAuth>(
    () => DataSourcePatientAuthImplement(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<RegisterPatientReopsitory>(
    () => RegisterPatientRepositoryImplement(
      dataSource: getIt<DataSourcePatientAuth>(),
    ),
  );
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
  getIt.registerLazySingleton<DataSourcePharmacyAuth>(
    () => DataSourcePharmacyAuthImplement(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<RegisterPharmacyReopsitory>(
    () => RegisterPharmacyRepositoryImplement(
      dataSource: getIt<DataSourcePharmacyAuth>(),
    ),
  );
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
  getIt.registerLazySingleton<FacilityAuthDatasource>(
    () => FacilituAuthDatasourceImp(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<FacilityRegisterRepo>(
    () => FacilityAuthRepoImp(
      facilityAuthDatasource: getIt<FacilityAuthDatasource>(),
    ),
  );
  getIt.registerLazySingleton<FaciclityUsecaseRegister>(
    () => FaciclityUsecaseRegister(
      facilityRegisterRepo: getIt<FacilityRegisterRepo>(),
    ),
  );
  getIt.registerFactory<FacilityAuthCubit>(
    () => FacilityAuthCubit(useCase: getIt<FaciclityUsecaseRegister>()),
  );
}

void _initPatientOnboardingInfoModule() {
  getIt.registerLazySingleton<PatientAllInfoDatasource>(
    () => PatientAllInfoDatasourceImp(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<PatientAllInfoRepo>(
    () => PatientAllInfoRepoImp(datasource: getIt<PatientAllInfoDatasource>()),
  );
  getIt.registerLazySingleton<PatientAllInfoUsacse>(
    () => PatientAllInfoUsacse(repo: getIt<PatientAllInfoRepo>()),
  );
  getIt.registerFactory<AllInfoCubit>(
    () => AllInfoCubit(updateAllInfoUseCase: getIt<PatientAllInfoUsacse>()),
  );
}

void _initPatientProfileModule() {
  getIt.registerLazySingleton<PatientProfileDataSource>(
    () => PatientProfileDataSourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<PatientProfileRepo>(
    () => PatientProfileRepoImp(dataSource: getIt<PatientProfileDataSource>()),
  );
  getIt.registerLazySingleton<GetProfileUsecase>(
    () => GetProfileUsecase(repo: getIt<PatientProfileRepo>()),
  );
  getIt.registerLazySingleton<UpdateBasicInfoUsecase>(
    () => UpdateBasicInfoUsecase(repo: getIt<PatientProfileRepo>()),
  );
  getIt.registerLazySingleton<UpdateMedInfoUsecase>(
    () => UpdateMedInfoUsecase(repo: getIt<PatientProfileRepo>()),
  );
  getIt.registerFactory<PatientProfileCubit>(
    () => PatientProfileCubit(
      getProfileUsecase: getIt<GetProfileUsecase>(),
      updateBasicInfoUsecase: getIt<UpdateBasicInfoUsecase>(),
      updateMedInfoUsecase: getIt<UpdateMedInfoUsecase>(),
    ),
  );
}

void _initPatientMedicationModule() {
  getIt.registerLazySingleton<MedicationDataSource>(
    () => MedicationDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<MedicationRepo>(
    () => MedicationRepoImp(dataSource: getIt<MedicationDataSource>()),
  );
  getIt.registerFactory<MedicationCubit>(
    () => MedicationCubit(repo: getIt<MedicationRepo>()),
  );
}

void _initPatientHomeModule() {
  getIt.registerLazySingleton<UserUseCase>(() => UserUseCase());
  getIt.registerFactory<UsersCubit>(() => UsersCubit(getIt<UserUseCase>()));
}

void _initPatientSearchModule() {
  getIt.registerLazySingleton<SearchDoctorLocalDs>(
    () => SearchDoctorLocalDsImp(sharedPreferences: getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<SearchDoctorRemoteDs>(
    () => SearchDoctorRemoteDsImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<SearchDoctorRepo>(
    () => SearchDoctorRepoImp(
      remoteDs: getIt<SearchDoctorRemoteDs>(),
      localDs: getIt<SearchDoctorLocalDs>(),
    ),
  );
  getIt.registerFactory<SearchDoctorCubit>(
    () => SearchDoctorCubit(searchDoctorRepo: getIt<SearchDoctorRepo>()),
  );
}

void _initPatientAppointmentModule() {
  getIt.registerLazySingleton<AppointmentDatasource>(
    () => AppointmentDatasourcseImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<AppointmentRepo>(
    () => AppointmentRepoImp(datasource: getIt<AppointmentDatasource>()),
  );
  getIt.registerLazySingleton<GetPatientAppo>(
    () => GetPatientAppo(repo: getIt<AppointmentRepo>()),
  );
  getIt.registerLazySingleton<ReschedualAppoUsecase>(
    () => ReschedualAppoUsecase(repo: getIt<AppointmentRepo>()),
  );
  getIt.registerLazySingleton<CancelAppointmentUsecase>(
    () => CancelAppointmentUsecase(repo: getIt<AppointmentRepo>()),
  );
  getIt.registerFactory<AppointmentCubit>(
    () => AppointmentCubit(
      usecase: getIt<GetPatientAppo>(),
      reschedualAppoUsecase: getIt<ReschedualAppoUsecase>(),
      cancelAppointmentUsecase: getIt<CancelAppointmentUsecase>(),
    ),
  );
}

void _initPatientNotificationModule() {
  getIt.registerLazySingleton<NotificationDatasource>(
    () => NotificationDatasourcseImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImp(datasource: getIt<NotificationDatasource>()),
  );
  getIt.registerLazySingleton<GetNotificationUsecase>(
    () => GetNotificationUsecase(repo: getIt<NotificationRepo>()),
  );
  getIt.registerFactory<NotificationCubit>(
    () => NotificationCubit(usecase: getIt<GetNotificationUsecase>()),
  );
}

void _initBookAppointment() {
  getIt.registerLazySingleton<BookAppoDatasource>(
    () => BookAppoDatasourcdeImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<BookAppoRepo>(
    () => BookAppoRepoImp(datasource: getIt<BookAppoDatasource>()),
  );
  getIt.registerLazySingleton<BookAppoUsecase>(
    () => BookAppoUsecase(repo: getIt<BookAppoRepo>()),
  );
  getIt.registerLazySingleton<GetSlotsUsecase>(
    () => GetSlotsUsecase(repo: getIt<BookAppoRepo>()),
  );
  getIt.registerLazySingleton<GwtDoctorClinicUsecase>(
    () => GwtDoctorClinicUsecase(repo: getIt<BookAppoRepo>()),
  );
  getIt.registerFactory<BookCubit>(
    () => BookCubit(
      getSlotsUsecase: getIt<GetSlotsUsecase>(),
      bookAppoUsecase: getIt<BookAppoUsecase>(),
      gwtDoctorClinicUsecase: getIt<GwtDoctorClinicUsecase>(),
    ),
  );
}

void _initFindLabModule() {
  getIt.registerLazySingleton<LabSearchDatasource>(
    () => LabSearchDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<SearchLabRepo>(
    () => SearchLabRepoImp(datasource: getIt<LabSearchDatasource>()),
  );
  getIt.registerLazySingleton<LabSearchUsecase>(
    () => LabSearchUsecase(repo: getIt<SearchLabRepo>()),
  );

  getIt.registerFactory<LabSearchCubit>(
    () => LabSearchCubit(usecase: getIt<LabSearchUsecase>()),
  );
}

void _initGetLabResultModule() {
  getIt.registerLazySingleton<LabResultDatasource>(
    () => LabResultDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<LabResultRepo>(
    () => LabResultRepoImp(datasource: getIt<LabResultDatasource>()),
  );
  getIt.registerLazySingleton<GetLabResultsUsecase>(
    () => GetLabResultsUsecase(repo: getIt<LabResultRepo>()),
  );
  getIt.registerFactory<LabResultCubit>(
    () => LabResultCubit(usecase: getIt<GetLabResultsUsecase>()),
  );
}

void _initChatbotPatientModule() {
  getIt.registerLazySingleton<ChatbotPatientDatasource>(
    () => ChatbotPatientDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<ChatbotPatientRepo>(
    () => ChatbotPatientRepoImp(datasource: getIt<ChatbotPatientDatasource>()),
  );
  getIt.registerLazySingleton<ChatbotPatientUsecase>(
    () => ChatbotPatientUsecase(repo: getIt<ChatbotPatientRepo>()),
  );
  getIt.registerFactory<ChatbotPatientCubit>(
    () => ChatbotPatientCubit(usecase: getIt<ChatbotPatientUsecase>()),
  );
}

void _initSearchPharmacyModule() {
  getIt.registerLazySingleton<PharmacySearchDatasource>(
    () => PharmacySearchDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<PharmacySearchRepo>(
    () => PharmacySearchRepoImp(datasource: getIt<PharmacySearchDatasource>()),
  );
  getIt.registerLazySingleton<PharmacySearchUsecase>(
    () => PharmacySearchUsecase(repo: getIt<PharmacySearchRepo>()),
  );
  getIt.registerLazySingleton<GetPharmacyProfileUsecase>(
    () => GetPharmacyProfileUsecase(repo: getIt<PharmacySearchRepo>()),
  );
  getIt.registerLazySingleton<GetPharmacyMedicinesUsecase>(
    () => GetPharmacyMedicinesUsecase(repo: getIt<PharmacySearchRepo>()),
  );
  getIt.registerLazySingleton<GetMedicineDetailsUsecase>(
    () => GetMedicineDetailsUsecase(repo: getIt<PharmacySearchRepo>()),
  );
  getIt.registerFactory<PharmacySearchCubit>(
    () => PharmacySearchCubit(
      usecase: getIt<PharmacySearchUsecase>(),
      getPharmacyProfileUsecase: getIt<GetPharmacyProfileUsecase>(),
      getPharmacyMedicinesUsecase: getIt<GetPharmacyMedicinesUsecase>(),
      getMedicineDetailsUsecase: getIt<GetMedicineDetailsUsecase>(),
    ),
  );
}

void _initAnalzeLabResultModule() {
  getIt.registerLazySingleton<AiLabReportDatasource>(
    () => AiLabReportDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<LabReportRepo>(
    () => LabReportRepoImp(datasource: getIt<AiLabReportDatasource>()),
  );
  getIt.registerLazySingleton<AnalyzeReportUsecase>(
    () => AnalyzeReportUsecase(repo: getIt<LabReportRepo>()),
  );
  getIt.registerFactory<AiReportCubit>(
    () => AiReportCubit(usecase: getIt<AnalyzeReportUsecase>()),
  );
}

void _initCartModule() {
  getIt.registerLazySingleton<CartCubit>(() => CartCubit());
}

void _initCheckoutModule() {
  getIt.registerLazySingleton<CheckoutDatasource>(
    () => CheckoutDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<CheckoutRepo>(
    () => CheckoutRepoImp(datasource: getIt<CheckoutDatasource>()),
  );
  getIt.registerLazySingleton<CheckoutUsecase>(
    () => CheckoutUsecase(repo: getIt<CheckoutRepo>()),
  );
  getIt.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(checkoutUsecase: getIt<CheckoutUsecase>()),
  );
}

void _initPaymentModule() {
  getIt.registerLazySingleton<PaymentDatasource>(
    () => PaymentOnlineImp(api: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<PaymentRepo>(
    () => PaymentRepoImp(datasource: getIt<PaymentDatasource>()),
  );

  getIt.registerLazySingleton<PaymentOnlineUsecase>(
    () => PaymentOnlineUsecase(repo: getIt<PaymentRepo>()),
  );

  getIt.registerFactory<PaymentCubit>(
    () => PaymentCubit(usecase: getIt<PaymentOnlineUsecase>()),
  );
}

void _initOrderTrackModule() {
  getIt.registerLazySingleton<OrderTrackDatasource>(
    () => OrderTrackDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<OrderTrackRepo>(
    () => OrderTrackRepoImp(datasource: getIt<OrderTrackDatasource>()),
  );
  getIt.registerLazySingleton<OrderTrackUsecase>(
    () => OrderTrackUsecase(repo: getIt<OrderTrackRepo>()),
  );

  getIt.registerLazySingleton<ConfirmOrderUsecase>(
    () => ConfirmOrderUsecase(repo: getIt<OrderTrackRepo>()),
  );
  getIt.registerFactory<OrderTrackCubit>(
    () => OrderTrackCubit(
      usecase: getIt<OrderTrackUsecase>(),
      confirmOrderUsecase: getIt<ConfirmOrderUsecase>(),
    ),
  );
}

void _initGetOrdersModule() {
  getIt.registerLazySingleton<GetOrdersUsecase>(
    () => GetOrdersUsecase(repo: getIt<CheckoutRepo>()),
  );
  getIt.registerFactory<GetOrdersCubit>(
    () => GetOrdersCubit(usecase: getIt<GetOrdersUsecase>()),
  );
}

/***************************************** */

void _initLabProfileModule() {
  getIt.registerLazySingleton<LabProfileDatasource>(
    () => LabProfileDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<LabProfileRepo>(
    () => LabProfileRepoImp(datasource: getIt<LabProfileDatasource>()),
  );
  getIt.registerLazySingleton<GetLabProfileUsecase>(
    () => GetLabProfileUsecase(repo: getIt<LabProfileRepo>()),
  );
  getIt.registerLazySingleton<UpdateLabProfileUsecase>(
    () => UpdateLabProfileUsecase(repo: getIt<LabProfileRepo>()),
  );
  getIt.registerFactory<LabProfileCubit>(
    () => LabProfileCubit(
      getLabProfileUsecase: getIt<GetLabProfileUsecase>(),
      updateLabProfileUsecase: getIt<UpdateLabProfileUsecase>(),
    ),
  );
}

void _initLabServicesModule() {
  getIt.registerLazySingleton<LabServicesDatasource>(
    () => LabServicesDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<LabServicesRepo>(
    () => LabServicesRepoImp(datasource: getIt<LabServicesDatasource>()),
  );
  getIt.registerLazySingleton<GetCenterServicesUsecase>(
    () => GetCenterServicesUsecase(repo: getIt<LabServicesRepo>()),
  );
  getIt.registerLazySingleton<ToggleServiceUsecase>(
    () => ToggleServiceUsecase(repo: getIt<LabServicesRepo>()),
  );

  getIt.registerFactory<LabServicesCubit>(
    () => LabServicesCubit(
      getCenterServicesUsecase: getIt<GetCenterServicesUsecase>(),
      toggleServiceUsecase: getIt<ToggleServiceUsecase>(),
    ),
  );
}

void _initLabDashboardModule() {
  getIt.registerLazySingleton<LabDashboardDatasource>(
    () => LabDashboardDatasourceImp(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<LabDashboardRepo>(
    () => LabDashboardRepoImp(datasource: getIt<LabDashboardDatasource>()),
  );
  getIt.registerLazySingleton<GetLabDashboardUsecase>(
    () => GetLabDashboardUsecase(repo: getIt<LabDashboardRepo>()),
  );

  getIt.registerFactory<LabDashboardCubit>(
    () => LabDashboardCubit(
      getLabDashboardUsecase: getIt<GetLabDashboardUsecase>(),
    ),
  );
}
