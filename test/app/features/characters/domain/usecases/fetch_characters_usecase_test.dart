import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/error/failure.dart';
import 'package:marvel_app/app/features/characters/domain/entities/character_entity.dart';
import 'package:marvel_app/app/features/characters/domain/repositories/marvel_repository.dart';
import 'package:marvel_app/app/features/characters/domain/usecases/fetch_characters_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockMarvelRepository extends Mock implements MarvelRepository {}

void main() {
  late FetchCharactersUseCase fetchCharactersUseCase;
  late MockMarvelRepository mockMarvelRepository;

  setUp(() {
    mockMarvelRepository = MockMarvelRepository();
    fetchCharactersUseCase = FetchCharactersUseCaseImpl(mockMarvelRepository);
  });

  group('FetchCharactersUseCase', () {
    final characters = [
      CharacterEntity(
          id: 1, name: 'Spider-Man', description: 'A superhero', thumbnail: ''),
      CharacterEntity(
          id: 2,
          name: 'Iron Man',
          description: 'A billionaire hero',
          thumbnail: ''),
    ];

    test(
        'should return list of characters when the repository call is successful',
        () async {
      when(() => mockMarvelRepository.fetchCharacters()).thenAnswer(
        (_) async => Right(characters),
      );

      final result = await fetchCharactersUseCase.call();

      expect(result, isA<Right<Failure, List<CharacterEntity>>>());
      final rightResult = result.getOrElse(() => []);
      expect(rightResult, characters);
      verify(() => mockMarvelRepository.fetchCharacters()).called(1);
    });

    test('should return a failure when the repository call fails', () async {
      when(() => mockMarvelRepository.fetchCharacters()).thenAnswer(
        (_) async => Left(ServerFailure()),
      );

      final result = await fetchCharactersUseCase.call();

      expect(result, isA<Left<Failure, List<CharacterEntity>>>());
      final leftResult = result.fold((failure) => failure, (r) => null);
      expect(leftResult, isA<ServerFailure>());
      verify(() => mockMarvelRepository.fetchCharacters()).called(1);
    });
  });
}
