import 'package:flutter/material.dart';


class WritersModel with ChangeNotifier{
  Color _pickerColor = Colors.black;
  Color _selectedColor = Colors.black;
  changeColor(Color selectedColorGot){
    _selectedColor= selectedColorGot;
    notifyListeners();
  }
  Color get selectedColor =>_selectedColor;
   Color get pickerColor =>_pickerColor;

}