import 'package:permission_handler/permission_handler.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  Database db;
  Future createDb()async{
    String path = '${await getDatabasesPath()}article.db';
    db = await openDatabase(path,version: 1,onCreate: (db,version){
      db.execute('CREATE TABLE ArticleTable (id INTEGER PRIMARY KEY, title TEXT, body TEXT)');
    });
  }

  Future<int> saveArticle(FullArticle article)async{

    await createDb();

      String databasePath = await getDatabasesPath();

      // var path = '$databasePath article.db';
      // Database db = await openDatabase(path, version: 1, onCreate: (db, version) {
      //   db.execute(
      //       'CREATE TABLE ArticleTable (id INTEGER PRIMARY KEY, title TEXT, body TEXT)');
      // });

      return await db.rawInsert(
          'INSERT INTO ArticleTable(title,body) VALUES("${article.title}", "${article.body}")');

    print('saved');

  }

  Future<List<Map<String,String>>> readAllData()async{
    await createDb();
    return await db.query('ArticleTable');
    //return await db.rawQuery('SELECT * FROM ArticleTable');
  }
}