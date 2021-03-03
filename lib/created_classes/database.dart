import 'dart:typed_data';

import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static Database db;

  Future _createDb() async {
    String path = '${await getDatabasesPath()}article.db';
    db = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE ArticleTable (id INTEGER PRIMARY KEY, title TEXT, body TEXT)');
    });
  }

  Future _createDbForPic() async {
    String path = '${await getDatabasesPath()}profile_pic.db';
    db = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE PictureTable (id INTEGER PRIMARY KEY, picture BLOB)');
    });
  }



  savePicToDb(Uint8List imageFile)async{
    await _createDbForPic();
    try {
      await db.rawInsert('INSERT INTO PictureTable(picture) VALUES("${imageFile}")');

    } on Exception catch (e) {
      print('Failed to cache pic \n e');
    }

  }
  var profilePic;

  Future<void> retrievePicFromDataBase()async{
    await _createDbForPic();
    try {

      List<Map<String,dynamic>> listOfPics =  await  db.query('PictureTable', columns: ['picture']);
      var indexOfSecondLast = listOfPics.length-2;


        await db.rawDelete('DELETE FROM PictureTable WHERE id = ${indexOfSecondLast}', );


      print('$listOfPics');
      if(listOfPics.isNotEmpty) profilePic = listOfPics.last['picture'];
    } on Exception catch (e) {
      print('Failed to retrieve pic from data base \n e');
    }

  }
  List<Map> list = [];



  Future<int> saveArticle(FullArticle article) async {
    await _createDb();
    int row = await db.rawInsert(
        'INSERT INTO ArticleTable(title,body) VALUES("${article.title}", "${article.body}")');
    list = await db.query('ArticleTable', columns: ['title','body']);
    //print(row);
    return row-1;
    print('saved');
  }
  deleteArticleLocally(FullArticle article)async{
   _createDb();
    try {
      await db.rawDelete('DELETE FROM ArticleTable WHERE id = ${article.id}', );
    } on Exception catch (e) {
      print('Failed to delete articles \n\n\n$e');
    }
  }
  Future<void> initializeList()async{
    list = await db.query('ArticleTable', columns: ['title','body']);
  }

  Future<List<Map>> readAllData() async {
    await _createDb();
    return await db.query('ArticleTable', columns: null);

    //return await db.rawQuery('SELECT * FROM ArticleTable');
  }
}
