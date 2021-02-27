
import 'package:flutter/material.dart';
import 'package:writers_app/created_classes/writer_profile.dart';
import 'saving_methods.dart';
import 'dart:core';



class WritersModel with ChangeNotifier,SavingMethods{
  Profile profile;

  TextEditingController nameController;



 String get userName{
 return  auth.currentUser.displayName??auth.currentUser.email??'UnKnown';
}
initializeName(){
   if(nameController==null) {
     nameController = TextEditingController();
     nameController.text = userName;
     notifyListeners();
   }

}
setName(String name){
   nameController.text = name;
   notifyListeners();
}




  var _pickerColor = Colors.black;
  var _selectedColor = Colors.black;



  onChecked(int index,bool isChecked,List<Map<String,String>> list){
    if(selectedBox==null){
      selectedBox=List<Map<String,String>>(list.length);

    }


    final article =list[index];
    if (isChecked) selectedBox[index]=article;
  else {
    if(index<selectedBox.length)

      selectedBox[index] = null;
    }
    notifyListeners();
  }

  changeColor(Color selectedColorGot){
    _selectedColor= selectedColorGot;
        notifyListeners();
  }

   //FirebaseAuth auth= FirebaseAuth.instance;
  void signout(){
    Color color = Colors.white;
    auth.signOut();
    notifyListeners();
  }

  Color get selectedColor =>_selectedColor;
   Color get pickerColor =>_pickerColor;


}