import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/error/exception.dart';
import 'package:marvel_app/app/core/error/failure.dart';
import 'package:marvel_app/app/features/characters/data/datasources/marvel_remote_datasource.dart';
import 'package:marvel_app/app/features/characters/domain/entities/character_entity.dart';
import 'package:marvel_app/app/features/characters/infra/repositories/marvel_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockMarvelRemoteDataSource extends Mock
    implements MarvelRemoteDataSource {}

void main() {
  late MarvelRepositoryImpl repository;
  late MockMarvelRemoteDataSource mockMarvelRemoteDataSource;

  setUp(() {
    mockMarvelRemoteDataSource = MockMarvelRemoteDataSource();
    repository = MarvelRepositoryImpl(mockMarvelRemoteDataSource);
  });

  group('fetchCharacters', () {
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

    test('should return a list of CharacterEntity when the call is successful',
        () async {
      when(() => mockMarvelRemoteDataSource.fetchCharacters())
          .thenAnswer((_) async => apiResponse);

      final result = await repository.fetchCharacters();

      expect(result, isA<Right<Failure, List<CharacterEntity>>>());
      final characters = (result as Right).value;
      expect(characters, isA<List<CharacterEntity>>());
      expect(characters[0].id, 1);
      expect(characters[0].name, 'Spider-Man');
      expect(characters[0].description, 'A hero in the Marvel Universe');

      verify(() => mockMarvelRemoteDataSource.fetchCharacters()).called(1);
    });

    test('should return ServerFailure when there is a ServerException',
        () async {
      when(() => mockMarvelRemoteDataSource.fetchCharacters())
          .thenThrow(ServerException());

      final result = await repository.fetchCharacters();

      expect(result, isA<Left<Failure, List<CharacterEntity>>>());
      final failure = (result as Left).value;
      expect(failure, isA<ServerFailure>());

      verify(() => mockMarvelRemoteDataSource.fetchCharacters()).called(1);
    });
  });
}
