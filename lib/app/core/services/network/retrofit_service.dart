import 'package:marvel_app/app/core/env/app_envs.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_service.g.dart';

@RestApi(baseUrl: AppEnvs.apiUrl, )
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String baseUrl}) = _RetrofitService;

  @GET("characters")
  Future<HttpResponse<dynamic>> fetchCharacters(
    @Query("ts") String timestamp,
    @Query("apikey") String apiKey,
    @Query("hash") String hash,
  );
}
