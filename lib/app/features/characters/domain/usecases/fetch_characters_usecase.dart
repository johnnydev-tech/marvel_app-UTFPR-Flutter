import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

import '../entities/character_entity.dart';
import '../repositories/marvel_repository.dart';

abstract class FetchCharactersUseCase {
  Future<Either<Failure, List<CharacterEntity>>> call();
}

class FetchCharactersUseCaseImpl implements FetchCharactersUseCase {
  final MarvelRepository repository;

  FetchCharactersUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call() async {
    return await repository.fetchCharacters();
  }
}
