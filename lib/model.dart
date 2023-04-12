import 'package:flutter/cupertino.dart';

class RecipeModel {
  late String applabel;
  late String appimgurl;
  late double appcalories;
  late String appurl;

  RecipeModel({this.applabel='',this.appimgurl='',this.appcalories=0,this.appurl=''});
  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimgurl: recipe["image"],
      appurl: recipe["url"],
    );
  }


}