import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:writers_app/created_classes/database.dart';
import 'dart:core';



class WritersModel with ChangeNotifier{
  var _pickerColor = Colors.black;
  var _selectedColor = Colors.black;
  TextEditingController bodyController=TextEditingController();
  TextEditingController titleController=TextEditingController();

  MyDatabase db = MyDatabase();
  final List<Map> listOfArticles = [];

  // addToList(){
  //   listOfArticles.add(value)
  // }


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