
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:writers_app/created_classes/database.dart';

mixin SavingMethods{
  TextEditingController bodyController=TextEditingController();
  TextEditingController titleController=TextEditingController();

  MyDatabase db = MyDatabase();
  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  List<Map<String,String>> selectedBox ;
  List<Map<String,String>> selectedArticles ;
  String get user=> auth.currentUser.uid;


  List<FullArticle> articlesFetched = [];

  Future<void> upLoadPicAndSaveUrl(File image) async {

      String imageURL = await uploadFile(image);
      DocumentSnapshot docSnapShot =await profilePicRef.get();
      if(!docSnapShot.exists) profilePicRef.set({"profile": imageURL});

     else  profilePicRef.update({"profile": imageURL});

  }
  DocumentReference get profilePicRef=>fireStore.collection(user).doc('profile_pic');





  Future<String> uploadFile(File _image) async {
    //final docRef = fireStore.collection(user).doc('profile_pic');
    //await FirebaseStorage.instance.ref().delete();

    ///////////////////////////////////
    //final oldstorageReference = FirebaseStorage.instance.ref();
    try {
      //oldstorageReference.child('profile').storage.;
      final downloadurlMap = await fireStore.collection(user).doc('profile_pic').get();
      final String downloadurl = downloadurlMap['profile'].toString();

      String fileUrl =Uri.decodeFull(downloadurl).replaceAll(RegExp(r'(\?alt).*'), '');
      final photoRef =  FirebaseStorage.instance.refFromURL(fileUrl);
      photoRef.delete();


    }catch(e){
      _error;
      print('Delete of old pics failed \n error : $e');
      _error;
    }
     final storageReference =FirebaseStorage.instance.ref()
        .child('profile/${_image.path}');
    //////////////////////////////////
    final uploadTask =await storageReference.putFile(_image);

    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL =  fileURL;
    });
    _error;
    print('URL got');
    _error;

    return returnURL;

  }
  get _error{
    print('____________________________________________');
  }

  _initializeSelectedArticles(){
    selectedArticles = selectedBox.where((element) => element!=null).toList();
  }


  fetchFromFirestore()async {
    if(articlesFetched.isEmpty){
      final docRef = fireStore.collection(user).doc('articles');
      final documentSnapshot = await docRef.get();
      var map = documentSnapshot.data();

      final keys = map.keys.toList();
      for (var key in keys) {
        final articleMap = map[key];
        final title = articleMap.keys.first.toString();
        final body = articleMap.values.first.toString();
        print(title);
        print(body);
        articlesFetched.add(FullArticle(title, body));
      }
    }
  }

  upLoad()async{
    selectedArticles=[];
    final docRef= fireStore.collection(user).doc('articles');
    _initializeSelectedArticles();
    print(selectedArticles);
    if(selectedArticles.isNotEmpty){
      for(var article in selectedArticles ){
        var title = article['title'];
        var body  = article['body'];
        await docRef.set({'$title':{title : body}},SetOptions(merge: true));
        articlesFetched.add(FullArticle(title, body));
      }
    }

  }


}