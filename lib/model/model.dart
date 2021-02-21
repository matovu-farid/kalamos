import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class WritersModel with ChangeNotifier{
  Color _pickerColor = Colors.black;
  Color _selectedColor = Colors.black;
  TextEditingController bodyController=TextEditingController();
  TextEditingController titleController=TextEditingController();


  WritersModel();
  changeColor(Color selectedColorGot){
    _selectedColor= selectedColorGot;
    notifyListeners();
  }
   FirebaseAuth auth= FirebaseAuth.instance;
  void signout(){
    auth.signOut();
    notifyListeners();

  }
  Color get selectedColor =>_selectedColor;
   Color get pickerColor =>_pickerColor;


}