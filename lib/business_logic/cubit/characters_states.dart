import 'package:breaking_app/data/models/quote_model.dart';

import '../../data/models/character_model.dart';

abstract class CharactersState {}

class InitialState extends CharactersState {}

class CharactersLoadingState extends CharactersState {}

class CharactersSuccessState extends CharactersState {
  final List<CharacterModel> characters;

  CharactersSuccessState(this.characters);
}

class QuoteLoadingState extends CharactersState {}

class QuoteSuccessState extends CharactersState {
  final List<QuoteModel> quotes;

  QuoteSuccessState(this.quotes);
}

class SearchState extends CharactersState {}

class ClearSearchState extends CharactersState {}

class ExitSearchState extends CharactersState {}
