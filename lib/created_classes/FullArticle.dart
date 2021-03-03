class FullArticle{

  final String title;
  final String body;
   int index ;
   final int id;

  FullArticle(this.title, this.body,this.id,{this.index=0});
  factory FullArticle.fromMap(Map map){
    return FullArticle(map['title'], map['body'], map['id']);
  }
  Map<String,String> toMap(){
    return {title:body};
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FullArticle &&
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
}