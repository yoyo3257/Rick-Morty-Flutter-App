class Character {
  late int charId;
  late String name;
  late String status;
  late String species;
  late String gender;
  late String image;
  late List<dynamic> episode;

  Character.fromJson(Map<String,dynamic> json){
    charId = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    gender = json['gender'];
    image = json['image'];
    episode = json['episode'];
}
}
