import 'package:writers_app/created_classes/original_article.dart';

class PlainArticle{

  final String title;
  final String body;
   int index ;
   final int id;

  PlainArticle(this.title, this.body,this.id,{this.index=0});
  factory PlainArticle.fromMap(Map map){
    return PlainArticle(map['title'], map['body'], map['id']);
  }
  Map<String,String> toMap(){
    return {title:body};
  }
  factory PlainArticle.fromOriginalArticle(OriginalArticle originalArticle){
   String title = originalArticle.title.toPlainText();
   String body = originalArticle.body.toPlainText();
   int id = originalArticle.id;
    return PlainArticle(title, body, id);
  }



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlainArticle &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          body == other.body &&
          id == other.id;

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ id.hashCode;

  @override
  String toString() {
    return 'FullArticle{title: $title, body: $body, id: $id}';
  }
  shared(){
    return '$title\n$body';
  }
}