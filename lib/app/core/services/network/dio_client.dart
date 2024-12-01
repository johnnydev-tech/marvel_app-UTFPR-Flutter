import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../env/app_envs.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEnvs.apiUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        responseBody: true,
        logPrint: (Object object) => log(object.toString(), name: 'DIO'),
      ),
    );
    return dio;
  }
}
