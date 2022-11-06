class CharacterModel{
  late int charId;//
  late String name;//
  late String birthday;
  late String image;//
  late String statusAliveOrDead;//
  late String nickName;//
  late String actorName;//
  late List jobs;//
  late List appearanceOfSeasons;//
  late List betterCallSaulAppearance;//

  CharacterModel.formJson(Map<String,dynamic>json){
    charId=json['char_id'];
    name=json['name'];
    birthday=json['birthday'];
    image=json['img'];
    statusAliveOrDead=json['status'];
    nickName=json['nickname'];
    actorName=json['portrayed'];
    jobs=json['occupation'];
    appearanceOfSeasons=json['appearance'];
    betterCallSaulAppearance=json['better_call_saul_appearance'];
  }



}