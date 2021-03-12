import 'dart:convert';

import 'package:quill_delta/quill_delta.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:zefyr/zefyr.dart';

class OriginalArticle{
  final NotusDocument title;
  final NotusDocument body;
  final int id;
  int index ;

  OriginalArticle(this.title, this.body, this.id,{index:0});
  factory OriginalArticle.fromPlainArticle(PlainArticle plainArticle){
    NotusDocument loadDocument(String text) => NotusDocument.fromDelta( Delta()..insert('$text\n'));
    return OriginalArticle(loadDocument(plainArticle.title), loadDocument(plainArticle.body), plainArticle.id);
  }

  factory OriginalArticle.fromJson(String encordedTitle,String encordedBody,int id){
    List titlelist = jsonDecode(encordedTitle);List bodylist = jsonDecode(encordedBody);
     final title = NotusDocument.fromJson(titlelist);final body = NotusDocument.fromJson(bodylist);
    return OriginalArticle(title, body, id);
  }


  Map<String,String> toMap(){
    return {jsonEncode(title):jsonEncode(body)};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OriginalArticle &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          body == other.body &&
          id == other.id &&
          index == other.index;

  @override
  int get hashCode =>
      title.hashCode ^ body.hashCode ^ id.hashCode ^ index.hashCode;
}