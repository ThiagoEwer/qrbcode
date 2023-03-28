import 'package:flutter/material.dart';


//ChangeNotifier é igual ao setState só que para a programação e não para a tela.
class ThemeController extends ChangeNotifier{
  static ThemeController intance = ThemeController();


  bool isDarktheme = false;
  changeTheme(){
  //trocando o valor do booleano com !
    isDarktheme = !isDarktheme;
    
  notifyListeners();
  }
  
}