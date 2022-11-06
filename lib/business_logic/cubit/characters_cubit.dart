import 'package:breaking_app/business_logic/cubit/characters_states.dart';
import 'package:breaking_app/data/repository/characters_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character_model.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;
  List<CharacterModel> characters = [];
  List<CharacterModel> searchCharacters = [];
  bool isSearch = false;

  CharactersCubit(this._charactersRepository) : super(InitialState());

  void getAllCharacters() {
    emit(CharactersLoadingState());
    _charactersRepository.getAllCharacters().then((characters) {
      this.characters = characters;
      emit(CharactersSuccessState(characters));
    });
  }

  void getCharacterQuote({required String characterName}) {
    emit(CharactersLoadingState());
    _charactersRepository
        .getCharacterQuote(characterName: characterName)
        .then((quotes) {
      emit(QuoteSuccessState(quotes));
    });
  }

  void openSearch(context) {
    isSearch = true;
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: exitSearch,
    ));
    emit(SearchState());
  }

  void searching(String text) {
    searchCharacters = characters
        .where(
          (element) => element.name.toLowerCase().contains(
                text.trim().toLowerCase(),
              ),
        )
        .toList();
    emit(SearchState());
  }

  void clearSearch(String text, context) {
    text.isEmpty
        ? {
            exitSearch(),
            Navigator.pop(context),
          }
        : searchCharacters.clear();
    emit(ClearSearchState());
  }

  void exitSearch() {
    isSearch = false;
    emit(ExitSearchState());
  }
}
