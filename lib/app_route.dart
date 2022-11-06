import 'package:breaking_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_app/data/models/character_model.dart';
import 'package:breaking_app/data/repository/characters_repository.dart';
import 'package:breaking_app/data/web_services/characters_web_services.dart';
import 'package:breaking_app/ui/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/strings.dart';
import 'ui/screens/characters_screen.dart';

class AppRoute {
  late final CharactersRepository _charactersRepository ;
  late final CharactersCubit     _charactersCubit ;
  AppRoute(){
    _charactersRepository = CharactersRepository(CharactersWebServices());
    _charactersCubit = CharactersCubit(_charactersRepository);

  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                _charactersCubit..getAllCharacters(),
            child:CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        CharacterModel character = settings.arguments as CharacterModel;
        return MaterialPageRoute(

          builder: (_) => BlocProvider(
            create: (context)=>CharactersCubit(_charactersRepository)
              ..getCharacterQuote(characterName: character.name),
            child:  CharacterDetailsScreen(character: character),
          ),
        );
    }
    return null;
  }
}
