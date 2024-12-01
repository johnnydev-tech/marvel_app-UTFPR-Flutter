import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

import '../../../../features/characters/domain/entities/character_entity.dart';
import '../../../../features/characters/domain/repositories/marvel_repository.dart';
import '../../data/datasources/marvel_remote_datasource.dart';
import '../models/character_model.dart';

class MarvelRepositoryImpl implements MarvelRepository {
  final MarvelRemoteDataSource remoteDataSource;

  MarvelRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CharacterEntity>>> fetchCharacters() async {
    try {
      final result = await remoteDataSource.fetchCharacters();

      final characters = (result['data']['results'] as List)
          .map((json) => CharacterModel.fromJson(json))
          .toList();
      return Right(characters
          .map(
            (model) => CharacterEntity(
              id: model.id,
              name: model.name,
              description: model.description,
            ),
          )
          .toList());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
