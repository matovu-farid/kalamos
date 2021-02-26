import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:writers_app/created_classes/database.dart';
import 'dart:core';

import 'package:writers_app/created_widgets/article/article_view.dart';



class WritersModel with ChangeNotifier{
  //List<MyListTile> listOfTiles = [];
  var _pickerColor = Colors.black;
  var _selectedColor = Colors.black;
  TextEditingController bodyController=TextEditingController();
  TextEditingController titleController=TextEditingController();

  MyDatabase db = MyDatabase();
  //final List<Map> listOfArticles = [];

  // addToTileList(MyListTile tile){
  //   listOfTiles.add(tile);
  //   notifyListeners();
  // }
  List<Map> selectedBox ;

  onChecked(int index,bool isChecked,List<Map<String,String>> list){
    if(selectedBox==null){
      selectedBox=List<Map>(list.length);

    }


    final article =list[index];
    if (isChecked) selectedBox[index]=article;
  else {
    if(index<selectedBox.length)

      selectedBox[index] = null;
    }
  print(selectedBox);
    notifyListeners();
  }




  changeColor(Color selectedColorGot){
    _selectedColor= selectedColorGot;
        notifyListeners();
  }

   FirebaseAuth auth= FirebaseAuth.instance;
  void signout(){
    Color color = Colors.white;
    auth.signOut();
    notifyListeners();
  }

  Color get selectedColor =>_selectedColor;
   Color get pickerColor =>_pickerColor;


}