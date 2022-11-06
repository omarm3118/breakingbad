import 'package:breaking_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_app/business_logic/cubit/characters_states.dart';
import 'package:breaking_app/constants/colors.dart';
import 'package:breaking_app/constants/strings.dart';
import 'package:breaking_app/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../widgets/character_item.dart';

class CharactersScreen extends StatelessWidget {
  CharactersScreen({Key? key}) : super(key: key);

  late List<CharacterModel> _allCharacters;
  late List<CharacterModel> _searchCharacters;
  late CharactersCubit cubit;

  final TextEditingController _textEditingController = TextEditingController();

  void init(context) {
    cubit = BlocProvider.of<CharactersCubit>(context);
  }

  double x = 32;

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
        backgroundColor: MyColors.myGrey,
        appBar: appBar(context),
        body: checkIfOfflineOrOnline(),
    );
  }

  AppBar appBar(context) {
    return !cubit.isSearch ? defaultAppBar(context) : searchAppBar(context);
  }

  AppBar defaultAppBar(context) {
    return AppBar(
      backgroundColor: MyColors.myYellow,
      title: const Text(
        'Characters',
        style: TextStyle(
          color: MyColors.myGrey,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              cubit.openSearch(context);
            },
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            )),
      ],
    );
  }

  AppBar searchAppBar(context) {
    return AppBar(
      backgroundColor: MyColors.myYellow,
      leading: const BackButton(
        color: MyColors.myGrey,
      ),
      title: TextField(
        controller: _textEditingController,
        cursorColor: MyColors.myGrey,
        style: const TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
        decoration: const InputDecoration(
          hintText: 'Find a character...',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: MyColors.myGrey,
            fontSize: 18,
          ),
        ),
        onChanged: (String onChanged) {
          cubit.searching(onChanged);
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            cubit.clearSearch(_textEditingController.text, context);
            _textEditingController.clear();
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ],
    );
  }

  Widget charactersBody() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (ctx, state) {
        if (state is CharactersLoadingState) {
          return fallBack();
        } else {
          _allCharacters = cubit.characters;
          _searchCharacters = cubit.searchCharacters;
          return buildCharactersList(); //fallBack();
        }
      },
    );
  }

  Widget buildCharactersList() {
    List<CharacterModel> chooseList =
    cubit.isSearch ? _searchCharacters : _allCharacters;
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: chooseList[index],
        );
      },
      itemCount: chooseList.length,
    );
  }

  Widget fallBack() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  checkIfOfflineOrOnline() {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return charactersBody();
        } else {
          return buildNoInternetScreen();
        }
      },
      builder: (ctx) {
        BlocProvider.of<CharactersCubit>(ctx).getAllCharacters();
        return Container();
      },
    );
  }

  buildNoInternetScreen() {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/noInternet.png',
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'No Connection!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
