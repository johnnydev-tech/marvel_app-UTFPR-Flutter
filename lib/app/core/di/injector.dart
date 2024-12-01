import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/characters/data/datasources/marvel_remote_datasource.dart';
import '../../features/characters/domain/repositories/marvel_repository.dart';
import '../../features/characters/domain/usecases/fetch_characters_usecase.dart';
import '../../features/characters/infra/repositories/marvel_repository_impl.dart';
import '../../features/characters/presenter/providers/characters_provider.dart';
import '../api/api_config_service.dart';
import '../env/app_envs.dart';
import '../navigator/navigator_handler.dart';
import '../services/device_info/device_info_service.dart';
import '../services/local_storage/flutter_security_storage.dart';
import '../services/local_storage/local_storage.dart';
import '../services/network/dio_client.dart';
import '../services/network/retrofit_service.dart';
import '../theme/theme_provider.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());

  getIt.registerLazySingleton<LocalStorage>(() => FlutterSecurityStorage());

  getIt.registerLazySingleton<ThemeProvider>(() => ThemeProvider(getIt()));

  getIt.registerLazySingleton<NavigatorHandler>(() => NavigatorHandlerImpl());

  getIt.registerLazySingleton<Dio>(() => DioClient.create());

  getIt.registerLazySingleton<RetrofitService>(
      () => RetrofitService(getIt<Dio>()));

  getIt.registerLazySingleton<ApiConfigService>(
    () => ApiConfigService(
      apiKey: AppEnvs.apiKey,
      apiSecret: AppEnvs.apiSecret,
    ),
  );

  getIt.registerLazySingleton<MarvelRemoteDataSource>(() =>
      MarvelRemoteDataSourceImpl(
          getIt<RetrofitService>(), getIt<ApiConfigService>()));

  getIt.registerLazySingleton<MarvelRepository>(
      () => MarvelRepositoryImpl(getIt<MarvelRemoteDataSource>()));

  getIt.registerLazySingleton<FetchCharactersUseCase>(
      () => FetchCharactersUseCaseImpl(getIt<MarvelRepository>()));

  getIt.registerFactory(
      () => CharactersProvider(getIt<FetchCharactersUseCase>()));
}
