import 'package:flutter/material.dart';

import '../../domain/usecases/fetch_characters_usecase.dart';
import '../states/characters_state.dart';

class CharactersProvider with ChangeNotifier {
  final FetchCharactersUseCase fetchCharactersUseCase;

  CharactersProvider(this.fetchCharactersUseCase);

  CharactersState _state = CharactersInitial();
  CharactersState get state => _state;

  Future<void> fetchCharacters() async {
    _state = CharactersLoading();
    notifyListeners();

    final result = await fetchCharactersUseCase();
    result.fold(
      (failure) {
        _state = CharactersError("Error fetching characters");
      },
      (characters) {
        _state = CharactersLoaded(characters);
      },
    );
    notifyListeners();
  }
}
