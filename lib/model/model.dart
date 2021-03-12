
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:writers_app/created_classes/original_article.dart';
import 'package:writers_app/created_classes/writer_profile.dart';
import 'saving_methods.dart';
import 'dart:core';



class WritersModel with ChangeNotifier,SavingMethods{
  Profile profile;
  List<Widget> listOfTiles = [];

  TextEditingController nameController;
  File image;
  final _picker = ImagePicker();

  Future<void> deleteFromCache()async{
    selectedArticles=[];
    initializeSelectedArticles();
    for(var article in selectedArticles){

     await db.deleteArticleLocally(article);
    }
    notifyListeners();
  }
Future<void> deleteSingle(OriginalArticle article)async{


     await db.deleteArticleLocally(article);
   // }
    notifyListeners();
  }

  List<PlainArticle> cloudSelected = [];

  fetchFromFirestore({bool fetch = false})async {
    if(articlesFetched.isEmpty||fetch==true){
      articlesFetched = [];
      final docRef = fireStore.collection(user).doc('articles');
      final documentSnapshot = await docRef.get();

      var map = documentSnapshot.data(); //{'${title.toPlainText()}':[id,title,body],}
      print(map);
      if(map!=null) {
        final keys = map.keys.toList();
        for (var key in keys) {
          final list = map[key];
          final id = list[0];
          final encordedTitle = list[1];
          final encordedBody = list[2];
          articlesFetched.add(
              OriginalArticle.fromJson(encordedTitle, encordedBody, id));
        }
      }
      notifyListeners();
    }


  }

  deleteMultipleFromCloud()async{

    if(articlesFetched!=null) {
      final selectedCloudArticles = cloudSelectedBox.where((
          element) => element != null).toList();
      for (var article in selectedCloudArticles) {

        await deleteArticleFromCloud(article);
        articlesFetched.removeAt(article.index);
      }
    }
    //notifyListeners();
  }
  Future deleteArticleFromCloud(OriginalArticle article)async{

    final docRef = await fireStore.collection(user).doc('articles');
    await docRef.update({'${article.title.toPlainText()}':FieldValue.delete(),});

    notifyListeners();
  }



  Future setProfilePic() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        try{
          image = await testCompressAndGetFile(File(pickedFile.path), '${pickedFile.path}001.jpeg');
        }
        catch(e){
         print('changing pic failed\n error : $e');
    }
    try{
      upLoadPicAndSaveUrl(image);
    }catch(e){
          print('Image was not uploaded \n error : $e');
    }
      } else {
        print('No image selected.');
      }
      db.savePicToDb(image.readAsBytesSync());
      notifyListeners();

  }

  Future<Uint8List> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 300,
      minHeight: 300,
      quality: 95,
      //rotate: 90,
    );

    return result;
  }
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 95,
      minWidth: 300,
      minHeight: 300
      //rotate: 180,
    );
    return result;
  }



 String get userName{
 return  auth.currentUser.displayName??auth.currentUser.email??'UnKnown';
}
initializeName(){
   if(nameController==null) {
     nameController = TextEditingController();
     nameController.text = userName;
     //notifyListeners();
   }

}
setName(String name){
   nameController.text = name;
   notifyListeners();
}

  var _pickerColor = Colors.black;
  var _selectedColor = Colors.black;
  List<PlainArticle> savedBox;

  List<OriginalArticle> cloudSelectedBox;

  onLongPress(int index,bool isChecked,List<OriginalArticle> list,String type) {
    if (type == 'local'){
      if (selectedBox == null) {
        selectedBox = List<OriginalArticle>(list.length);
      }

    final article = list[index];
    if (isChecked)
      selectedBox[index] = article;
    else {
      if (index < selectedBox.length)
        selectedBox[index] = null;
    }
  }else {
      if (cloudSelectedBox == null) {
        cloudSelectedBox = List<OriginalArticle>(list.length);
      }

      final article = list[index];
      if (isChecked)
        cloudSelectedBox[index] = article;

      else {
        if (index < cloudSelectedBox.length)
          cloudSelectedBox[index] = null;
      }
    }
    //notifyListeners();
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