import 'package:challenge/models/resources.dart';
import 'package:flutter/material.dart';

class ResourceList extends ChangeNotifier {
  final resources = Resources();

  int get lives {
    return resources.lives;
  }

  int get coins {
    return resources.coins;
  }

  void loseLife(){
    resources.lives > 0 ? resources.lives-- : resources.lives = 0;
    print('teste');
    notifyListeners();
  }

  void addLife(){
    resources.lives < 5 ? resources.lives++ : resources.lives = 5;
    notifyListeners();
  }

  void addCoins(){
    resources.coins+=5;
    notifyListeners();
  }

  void buyLife(){
    if(resources.coins >= 5 && resources.lives < 5){
      addLife();
      resources.coins-=5;
    }
  }
}