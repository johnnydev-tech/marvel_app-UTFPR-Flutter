import 'dart:developer';

import '../../../../core/api/api_config_service.dart';
import '../../../../core/env/app_envs.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/services/network/retrofit_service.dart';

abstract class MarvelRemoteDataSource {
  Future<Map<String, dynamic>> fetchCharacters();
}

class MarvelRemoteDataSourceImpl implements MarvelRemoteDataSource {
  final RetrofitService retrofitService;
  final ApiConfigService apiConfigService;

  MarvelRemoteDataSourceImpl(this.retrofitService, this.apiConfigService);

  @override
  Future<Map<String, dynamic>> fetchCharacters() async {
    try {
      final apiParams = apiConfigService.getApiParameters();

      log(AppEnvs.apiUrl);
      final response = await retrofitService.fetchCharacters(
        apiParams['ts']!,
        apiParams['apikey']!,
        apiParams['hash']!,
      );

      return response.data;
    } catch (error) {
      throw ServerException();
    }
  }
}
