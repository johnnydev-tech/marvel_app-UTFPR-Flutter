import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/error/failure.dart';
import 'package:marvel_app/app/features/characters/domain/entities/character_entity.dart';
import 'package:marvel_app/app/features/characters/domain/usecases/fetch_characters_usecase.dart';
import 'package:marvel_app/app/features/characters/presenter/providers/characters_provider.dart';
import 'package:marvel_app/app/features/characters/presenter/states/characters_state.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchCharactersUseCase extends Mock
    implements FetchCharactersUseCase {}

void main() {
  group('CharactersProvider', () {
    late MockFetchCharactersUseCase mockFetchCharactersUseCase;

    setUp(() {
      mockFetchCharactersUseCase = MockFetchCharactersUseCase();
    });

    test(
        'should emit loading state and then loaded state with characters on success',
        () async {
      final characters = [
        CharacterEntity(id: 1, name: 'Spider-Man', description: 'A superhero'),
        CharacterEntity(
            id: 2, name: 'Iron Man', description: 'A billionaire hero'),
      ];

      when(() => mockFetchCharactersUseCase()).thenAnswer(
        (_) async => Right(characters),
      );

      final provider = CharactersProvider(mockFetchCharactersUseCase);

      expect(provider.state, isA<CharactersInitial>());

      final fetchCharactersFuture = provider.fetchCharacters();

      expect(provider.state, isA<CharactersLoading>());

      await fetchCharactersFuture;

      expect(provider.state, isA<CharactersLoaded>());
      expect(
          (provider.state as CharactersLoaded).characters, equals(characters));
    });

    test('should emit error state when fetching characters fails', () async {
      when(() => mockFetchCharactersUseCase()).thenAnswer(
        (_) async => Left(ServerFailure()),
      );

      final provider = CharactersProvider(mockFetchCharactersUseCase);

      expect(provider.state, isA<CharactersInitial>());

      final fetchCharactersFuture = provider.fetchCharacters();

      expect(provider.state, isA<CharactersLoading>());

      await fetchCharactersFuture;

      expect(provider.state, isA<CharactersError>());
    });
  });
}
