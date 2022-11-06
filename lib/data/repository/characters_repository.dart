import 'package:breaking_app/data/models/character_model.dart';
import 'package:breaking_app/data/models/quote_model.dart';
import 'package:breaking_app/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices _charactersWebServices;

  CharactersRepository(this._charactersWebServices);

  Future<List<CharacterModel>> getAllCharacters() async {
    List characters = await _charactersWebServices.getAllCharacters();
    return characters
        .map((character) => CharacterModel.formJson(character))
        .toList();
  }

  Future<List<QuoteModel>> getCharacterQuote(
      {required String characterName}) async {
    List quotes = await _charactersWebServices.getCharacterQuote(
        characterName: characterName);
    return quotes
        .map(
          (quote) => QuoteModel.fromJson(json: quote),
        )
        .toList();
  }
}
