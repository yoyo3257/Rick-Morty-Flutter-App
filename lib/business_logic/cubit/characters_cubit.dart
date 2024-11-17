import 'package:bloc/bloc.dart';
import 'package:blocapp/data/models/characters.dart';
import 'package:blocapp/data/repositories/characters_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  late final CharactersRepository charactersRepository;
  late List<Character> characters = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAll() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
      print(this.characters);
    });
    return characters;
  }
}
