import 'package:blocapp/data/models/characters.dart';
import 'package:blocapp/data/web_services/character_api.dart';

class CharactersRepository {
  final CharactersWebService charactersWebService;

  CharactersRepository(this.charactersWebService);
  Future<List<Character>> getAllCharacters() async{
    final characters = await charactersWebService.getAllCharacters();
    print(characters);
    return characters.map((character)=> Character.fromJson(character)).toList();
  }
}
