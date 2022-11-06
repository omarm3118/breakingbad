import 'package:breaking_app/constants/colors.dart';
import 'package:breaking_app/constants/strings.dart';
import 'package:breaking_app/data/models/character_model.dart';
import 'package:breaking_app/ui/screens/character_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../data/repository/characters_repository.dart';
import '../../data/web_services/characters_web_services.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel character;

  const CharacterItem({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
            arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: characterImage(),
          ),
          footer: footer(),
        ),
      ),
    );
  }

  Widget characterImage() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: character.image.isNotEmpty
          ? FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: 'assets/images/loading.gif',
              placeholderFit: BoxFit.contain,
              image: character.charId != 3
                  ? character.image
                  : 'https://image.shutterstock.com/image-vector/fluid-flow-liquid-color-background-600w-1698551401.jpg',
            )
          : const Placeholder(),
    );
  }

  Widget footer() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black54,
      ),
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        character.name,
        style: const TextStyle(
          fontSize: 16,
          height: 1.3,
          color: MyColors.myWhite,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
