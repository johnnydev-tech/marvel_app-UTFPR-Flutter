import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:marvel_app/app/core/env/app_envs.dart';
import 'package:marvel_app/app/core/navigator/navigator_handler.dart';

import '../../features/characters/data/datasources/marvel_remote_datasource.dart';
import '../../features/characters/domain/repositories/marvel_repository.dart';
import '../../features/characters/domain/usecases/fetch_characters_usecase.dart';
import '../../features/characters/infra/repositories/marvel_repository_impl.dart';
import '../../features/characters/presenter/providers/characters_provider.dart';

import '../api/api_config_service.dart';
import '../network/dio_client.dart';
import '../network/retrofit_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
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
