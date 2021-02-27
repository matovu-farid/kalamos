
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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