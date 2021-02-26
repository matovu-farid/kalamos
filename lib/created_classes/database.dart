import 'package:permission_handler/permission_handler.dart';
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

  //get dataBase =>db;

  List<Map> list = [];



  Future<int> saveArticle(FullArticle article) async {
    await _createDb();
    int row = await db.rawInsert(
        'INSERT INTO ArticleTable(title,body) VALUES("${article.title}", "${article.body}")');
    list = await db.query('ArticleTable', columns: ['title','body']);
    return row;
    print('saved');
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
