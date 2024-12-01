import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/api/api_config_service.dart';
import 'package:marvel_app/app/core/error/exception.dart';
import 'package:marvel_app/app/core/services/network/retrofit_service.dart';
import 'package:marvel_app/app/features/characters/data/datasources/marvel_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';

class MockRetrofitService extends Mock implements RetrofitService {}

class MockApiConfigService extends Mock implements ApiConfigService {}

void main() {
  late MockRetrofitService mockRetrofitService;
  late MockApiConfigService mockApiConfigService;
  late MarvelRemoteDataSourceImpl dataSource;

  setUp(() {
    mockRetrofitService = MockRetrofitService();
    mockApiConfigService = MockApiConfigService();
    dataSource =
        MarvelRemoteDataSourceImpl(mockRetrofitService, mockApiConfigService);
  });

  group('MarvelRemoteDataSourceImpl', () {
    const apiResponse = {
      'data': {
        'results': [
          {
            'id': 1,
            'name': 'Spider-Man',
            'description': 'A hero in the Marvel Universe'
          }
        ]
      }
    };

    const apiParams = {
      'ts': '1',
      'apikey': 'test-api-key',
      'hash': 'test-hash',
      'apiUrl': 'https://api.marvel.com'
    };

    test('should return a map of characters on success', () async {
      when(() => mockApiConfigService.getApiParameters()).thenReturn(apiParams);

      final httpResponse = HttpResponse<Map<String, dynamic>>(
        apiResponse,
        Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 200,
        ),
      );

      when(() => mockRetrofitService.fetchCharacters(any(), any(), any()))
          .thenAnswer((_) async => httpResponse);

      final result = await dataSource.fetchCharacters();

      expect(result, equals(apiResponse));
      verify(() => mockApiConfigService.getApiParameters()).called(1);
      verify(() => mockRetrofitService.fetchCharacters(
              apiParams['ts']!, apiParams['apikey']!, apiParams['hash']!))
          .called(1);
    });

    test('should throw ServerException when an error occurs', () async {
      when(() => mockApiConfigService.getApiParameters()).thenReturn(apiParams);

      when(() => mockRetrofitService.fetchCharacters(any(), any(), any()))
          .thenThrow(Exception());

      expect(
          () => dataSource.fetchCharacters(), throwsA(isA<ServerException>()));
      verify(() => mockApiConfigService.getApiParameters()).called(1);
      verify(() => mockRetrofitService.fetchCharacters(
              apiParams['ts']!, apiParams['apikey']!, apiParams['hash']!))
          .called(1);
    });
  });
}
