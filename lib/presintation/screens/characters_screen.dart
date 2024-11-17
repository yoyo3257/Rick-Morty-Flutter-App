import 'package:blocapp/business_logic/cubit/characters_cubit.dart';
import 'package:blocapp/constants/colors.dart';
import 'package:blocapp/data/models/characters.dart';
import 'package:blocapp/presintation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedOnCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColor.myGreen,
      decoration: InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColor.myGreen,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: MyColor.myGreen,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedOnItemToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedOnItemToSearchedList(String searchedOnCharacter) {
    searchedOnCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedOnCharacter))
        .toList();
    setState(() {});
  }

  _buildAppBarAction() {
    if (_isSearching) {
      return IconButton(
        onPressed: () {
          _clearSearch();
          Navigator.pop(context);
        },
        icon: Icon(Icons.clear),
        color: MyColor.myGreen,
      );
    } else {
      return IconButton(
        onPressed: _startSearch,
        icon: Icon(
          Icons.search,
          color: MyColor.myGreen,
        ),
      );
    }
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAll();
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadedIndicator();
      }
    });
  }

  Widget showLoadedIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColor.myBlue,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColor.myGreen,
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedOnCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedOnCharacters[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(
        color: MyColor.myWhite,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Can\'t connect ... check The internet',
              style: TextStyle(
                fontSize: 24,
                color: MyColor.myGreen,
              ),
            ),
            Image.asset('assets/images/undraw_server_down_s4lk.png',),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.myBlue,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: [_buildAppBarAction()],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected = !connectivity.contains(ConnectivityResult.none);

          if (connected) {
            return buildBlockWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadedIndicator(),
      ),
    );
  }
}
