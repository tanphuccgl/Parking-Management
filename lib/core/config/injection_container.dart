import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:parking_management1/core/network/network_info.dart';
import 'package:parking_management1/feature/car_list/data/data_source/car_list_remote.dart';
import 'package:parking_management1/feature/car_list/data/repositories/car_list_repo_impl.dart';
import 'package:parking_management1/feature/car_list/domain/repositories/car_list_repo.dart';
import 'package:parking_management1/feature/car_list/domain/usecase/car_list.dart';
import 'package:parking_management1/feature/car_list/presentations/manager/car_list_bloc.dart';
import 'package:parking_management1/feature/home/data/data_source/capacity_remote.dart';
import 'package:parking_management1/feature/home/data/repo/capacity_repo_impl.dart';
import 'package:parking_management1/feature/home/domain/repo/capacity_repo.dart';
import 'package:parking_management1/feature/home/domain/usecase/get_capacity.dart';
import 'package:parking_management1/feature/home/presentations/manager/capacity_bloc.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/data/data_source/list_vahicle_in_park_remote.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/data/repo/list_vahicle_in_park_repo_impl.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/domain/repo/list_vahicle_in_park_repo.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/domain/usecase/list_vahicle_in_park.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/manager/list_vahicle_in_park_bloc.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/presentation/widgets/body_list_vahicle_in_park.dart';
import 'package:parking_management1/feature/login/data/data_sources/login_local_data_source.dart';
import 'package:parking_management1/feature/login/data/data_sources/login_remote_data_source.dart';
import 'package:parking_management1/feature/login/data/repositories/login_repository_impl.dart';
import 'package:parking_management1/feature/login/domain/repositories/login_repository.dart';
import 'package:parking_management1/feature/login/domain/usecase/get_current_user.dart';
import 'package:parking_management1/feature/login/domain/usecase/post_login.dart';
import 'package:parking_management1/feature/login/presentations/manager/login_bloc.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/data_source/account_remote.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/models/user_model.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/data/repositories/user_repo_impl.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/domain/repositories/user_repo.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/domain/usecase/get_user.dart';
import 'package:parking_management1/feature/sign_in/dang_ky_account/presentation/manager/user_bloc.dart';
import 'package:parking_management1/feature/time/time_all/data/data_source/time_all_remote.dart';
import 'package:parking_management1/feature/time/time_all/data/repo/time_all_repo_impl.dart';
import 'package:parking_management1/feature/time/time_all/domain/repo/time_all_repo.dart';
import 'package:parking_management1/feature/time/time_all/domain/usecase/get_time_all.dart';
import 'package:parking_management1/feature/time/time_all/presentation/manager/time_all_bloc.dart';
import 'package:parking_management1/feature/time/time_check_in/data/data_source/time_check_in_remote.dart';
import 'package:parking_management1/feature/time/time_check_in/data/repo/time_check_in_repo_impl.dart';
import 'package:parking_management1/feature/time/time_check_in/domain/repo/time_check_in_repo.dart';
import 'package:parking_management1/feature/time/time_check_in/domain/usecase/get_time_check_in.dart';
import 'package:parking_management1/feature/time/time_check_in/presentation/manager/time_check_in_bloc.dart';
import 'package:parking_management1/feature/time/time_check_out/data/data_source/time_check_out_remote.dart';
import 'package:parking_management1/feature/time/time_check_out/data/repo/time_check_out_repo_impl.dart';
import 'package:parking_management1/feature/time/time_check_out/domain/repo/time_check_out_repo.dart';
import 'package:parking_management1/feature/time/time_check_out/domain/usecase/time_check_out.dart';
import 'package:parking_management1/feature/time/time_check_out/presentation/manager/time_check_out_bloc.dart';
import 'package:parking_management1/feature/user_history/data/data_source/user_history_remote.dart';
import 'package:parking_management1/feature/user_history/data/repo/user_his_repo_impl.dart';
import 'package:parking_management1/feature/user_history/domain/repo/user_his_repo.dart';
import 'package:parking_management1/feature/user_history/domain/usecase/user_his.dart';
import 'package:parking_management1/feature/user_history/presentation/manager/user_hic_bloc.dart';
import 'package:parking_management1/feature/user_list/data/data_source/user_get_vehicle_remote.dart';
import 'package:parking_management1/feature/user_list/data/repositories/user_get_vehicle_repo_impl.dart';
import 'package:parking_management1/feature/user_list/domain/repositories/user_get_vehicle_repo.dart';
import 'package:parking_management1/feature/user_list/domain/usecase/user_get_vehicle.dart';
import 'package:parking_management1/feature/user_list/manager/user_get_vehicle_bloc.dart';
import 'package:parking_management1/feature/vahicle/data/data_source/vahicle_remote.dart';
import 'package:parking_management1/feature/vahicle/data/repositories/vahicle_repo_impl.dart';
import 'package:parking_management1/feature/vahicle/domain/repositories/vahicle_repo.dart';
import 'package:parking_management1/feature/vahicle/domain/usecase/get_vahicle.dart';
import 'package:parking_management1/feature/vahicle/presentation/manager/vahicle_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  ///
  //login
  sl.registerFactory(
    () => LoginBloc(
      lg: sl(),
      cu: sl(),
    ),
  );
  sl.registerFactory(
    () => ProductBloc(pr: sl()),
  );
  sl.registerFactory(
    () => UserGetVahicleBloc(pr: sl()),
  );
  sl.registerFactory(
    () => VahicleListBloc(pr: sl()),
  );
  sl.registerFactory(
    () => VahicleBloc(pr: sl()),
  );
  sl.registerFactory(
    () => TimeAllBloc(pr: sl()),
  );
  sl.registerFactory(
    () => TimeCheckInBloc(pr: sl()),
  );
  sl.registerFactory(
    () => TimeCheckOutBloc(pr: sl()),
  );
  sl.registerFactory(
    () => CapacityBloc(pr: sl()),
  );
  sl.registerFactory(
    () => ListVahicleInParkBloc(pr: sl()),
  );
  sl.registerFactory(
    () => UserHistoryBloc(pr: sl()),
  );

  ///use case
  //login
  sl.registerLazySingleton(() => PostLogin(loginRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(loginRepository: sl()));
  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => UserGetVahicle(sl()));
  sl.registerLazySingleton(() => VahicleList(sl()));
  sl.registerLazySingleton(() => GetVahicle(sl()));
  sl.registerLazySingleton(() => GetTimeAll(sl()));
  sl.registerLazySingleton(() => GetTimeCheckIn(sl()));
  sl.registerLazySingleton(() => GetTimeCheckOut(sl()));
  sl.registerLazySingleton(() => Capacity(sl()));
  sl.registerLazySingleton(() => ListVahicleInPark(sl()));
  sl.registerLazySingleton(() => UserHistory(sl()));

  ///repo
  //login
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
      networkInfo: sl(),
      loginLocalDataSource: sl(),
      loginRemoteDataSource: sl()));
  sl.registerLazySingleton<GetUserRepository>(() =>
      GetUserRepositoryImpl(networkInfo: sl(), productRemoteDataSource: sl()));
  sl.registerLazySingleton<UserGetVahicleRepository>(() =>
      UserGetVahicleRepositoryImpl(
          networkInfo: sl(), courseContentsRemoteDataSource: sl()));
  sl.registerLazySingleton<VahicleListRepository>(() =>
      VahicleListRepositoryImpl(
          networkInfo: sl(), courseContentsRemoteDataSource: sl()));
  sl.registerLazySingleton<VahicleRepository>(() => VahicleRepositoryImpl(
      networkInfo: sl(), courseContentsRemoteDataSource: sl()));
  sl.registerLazySingleton<TimeAllRepository>(() => TimeAllRepositoryImpl(
      networkInfo: sl(), courseContentsRemoteDataSource: sl()));
  sl.registerLazySingleton<TimeCheckInRepository>(() =>
      TimeCheckInRepositoryImpl(
          networkInfo: sl(), listTeacherRemoteDataSource: sl()));
  sl.registerLazySingleton<TimeCheckOutRepository>(() =>
      TimeCheckOutRepositoryImpl(
          networkOutfo: sl(), listTeacherRemoteDataSource: sl()));
  sl.registerLazySingleton<CapacityRepository>(() => CapacityRepositoryImpl(
      networkInfo: sl(), courseContentsRemoteDataSource: sl()));
  sl.registerLazySingleton<ListVahicleInParkRepository>(() =>
      ListVahicleInParkRepositoryImpl(
          networkInfo: sl(), courseContentsRemoteDataSource: sl()));
  sl.registerLazySingleton<UserHistoryRepository>(() =>
      UserHistoryRepositoryImpl(
          networkInfo: sl(), courseContentsRemoteDataSource: sl()));

  ///data source
  //login
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<GetUserRemoteDataSource>(
      () => GetUserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserGetVahicleRemoteDataSource>(
      () => UserGetVahicleRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<VahicleListRemoteDataSource>(
      () => VahicleListRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<TimeAllRemoteDataSource>(
      () => TimeAllRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<VahicleRemoteDataSource>(
      () => VahicleRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<TimeCheckInRemoteDataSource>(
      () => TimeCheckInRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<TimeCheckOutRemoteDataSource>(
      () => TimeCheckOutRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CapacityRemoteDataSource>(
      () => CapacityRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ListVahicleInParkRemoteDataSource>(
      () => ListVahicleInParkRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserHistoryRemoteDataSource>(
      () => UserHistoryRemoteDataSourceImpl(client: sl()));

  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
