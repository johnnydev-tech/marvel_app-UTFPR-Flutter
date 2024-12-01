import '../../domain/entities/character_entity.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharacterEntity> characters;
  CharactersLoaded(this.characters);
}

class CharactersError extends CharactersState {
  final String message;
  CharactersError(this.message);
}
