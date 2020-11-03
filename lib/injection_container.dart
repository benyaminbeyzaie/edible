import 'package:edible/features/edible/domain/use_cases/create_initialize_user_use_cae.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_provider.dart';
import 'features/edible/data/data_sources/edible_local_data_source.dart';
import 'features/edible/data/data_sources/edible_remote_data_source.dart';
import 'features/edible/data/repositories/edible_repository_implematation.dart';
import 'features/edible/domain/repositories/edible_repository.dart';
import 'features/edible/domain/use_cases/add_edible_use_case.dart';
import 'features/edible/domain/use_cases/get_edibles_data_use_case.dart';
import 'features/edible/domain/use_cases/get_user_use_case.dart';
import 'features/edible/presentation/manager/edible_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // DataBase
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Features
  sl.registerFactory(() => EdibleBloc(
      getEdiblesDataUseCase: sl(),
      getUserModelUseCase: sl(),
      addEdibleUseCase: sl(),
      initializeUser: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetEdiblesDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserModelUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddEdibleUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateInitializeUserUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<EdibleRepository>(
      () => EdibleRepositoryImplementation(
            localDataSource: sl(),
            remoteDataSource: sl(),
          ));

  // Data sources
  sl.registerLazySingleton<EdibleLocalDataSource>(
      () => EdibleLocalDataSource(sharedPreferences: sl()));
  sl.registerLazySingleton<EdibleRemoteDataSource>(
      () => EdibleRemoteDataSource(apiProvider: sl()));

  // Core

  // Externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => ApiProvider());
}
