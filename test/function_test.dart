 import 'package:flutter/material.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:writers_app/created_classes/database.dart';
import 'package:test/test.dart';


void main(){
   WidgetsFlutterBinding.ensureInitialized();

test('database test', ()async{
  MyDatabase db = MyDatabase();
  const title = 'Farid';
  const body ='I love to play football and chess';
  final article = FullArticle(title, body);
  int row= await db.saveArticle( article);
  expect(row.runtimeType, int);

});


}