import 'package:blocapp/constants/colors.dart';
import 'package:blocapp/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;

  const CharacterDetails({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.myBlue,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: TextStyle(color: Colors.black),
        ),
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

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColor.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColor.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColor.myBlue,
      height: 30,
      endIndent: endIndent,
      thickness: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myGreen,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Name : ', character.name),
                      buildDivider(315),
                      characterInfo('Status : ', character.status),
                      buildDivider(305),
                      characterInfo('Species : ', character.species),
                      buildDivider(300),
                      characterInfo('Gender : ', character.gender),
                      buildDivider(305),
                      characterInfo(
                          'Episodes : ',
                          character.episode
                              .join('')
                              .split('https://rickandmortyapi.com/api/episode/')
                              .join('/')),
                      buildDivider(270),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
