import 'package:blocapp/business_logic/cubit/characters_cubit.dart';
import 'package:blocapp/data/models/characters.dart';
import 'package:blocapp/data/repositories/characters_repo.dart';
import 'package:blocapp/data/web_services/character_api.dart';
import 'package:flutter/material.dart';
import '../constants/strings.dart';
import 'screens/character_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebService());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = setting.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharacterDetails(
            character: character,
          ),
        );
    }
    return null;
  }
}
//
