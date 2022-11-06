import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_app/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_app/business_logic/cubit/characters_states.dart';
import 'package:breaking_app/constants/colors.dart';
import 'package:breaking_app/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          sliverAppBar(),
          sliverList(),
        ],
      ),
    );
  }

  sliverAppBar() {
    return SliverAppBar(
      leading: const BackButton(
        color: MyColors.myWhite,
      ),
      backgroundColor: MyColors.myGrey,
      pinned: true,
      expandedHeight: 600,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickName,
          style: const TextStyle(color: MyColors.myWhite, fontSize: 30),
        ),
        collapseMode: CollapseMode.parallax,
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  sliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                characterInfo(
                  title: 'Job : ',
                  value: character.jobs.join(' / '),
                ),
                buildDivider(310),
                characterInfo(
                  title: 'Seasons : ',
                  value: character.appearanceOfSeasons.join(' / '),
                ),
                buildDivider(250),
                characterInfo(
                  title: 'Status : ',
                  value: character.statusAliveOrDead,
                ),
                buildDivider(300),
                if (character.betterCallSaulAppearance.isNotEmpty)
                  characterInfo(
                    title: 'Better Call Saul Seasons : ',
                    value: character.betterCallSaulAppearance.join(' / '),
                  ),
                if (character.betterCallSaulAppearance.isNotEmpty)
                  buildDivider(150),
                characterInfo(
                  title: 'Actor/Actress : ',
                  value: character.actorName,
                ),
                buildDivider(230),
                const SizedBox(
                  height: 50,
                ),
                quoteAnimation(),
              ],
            ),
          ),
          const SizedBox(
            height: 300,
          )
        ],
      ),
    );
  }

  characterInfo({required String title, required String value}) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      endIndent: endIndent,
      height: 30,
      thickness: 2,
    );
  }

  BlocBuilder<CharactersCubit, CharactersState> quoteAnimation() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is QuoteLoadingState) {
        return fallBack();
      }
      if (state is QuoteSuccessState) {
        if (state.quotes.isNotEmpty) {
          String quote = state.quotes[0].quote;
          return buildQuote(quote);
        }
      }
      return const SizedBox();
    });
  }

  Widget buildQuote(quote) {
    return Center(
      child: Column(
        children: [
          const Text(
            'QUOTE',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: MyColors.myWhite,
            ),
          ),
          buildDivider(0),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(
                  quote,
                  entryEnd: 0.3,
                  speed: const Duration(
                    seconds: 5,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: MyColors.myWhite,
                    shadows: [
                      Shadow(
                        blurRadius: 7,
                        color: Colors.red,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fallBack() {
    return const LinearProgressIndicator(
      color: MyColors.myYellow,
    );
  }
}
