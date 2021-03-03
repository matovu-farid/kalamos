class FullArticle{

  final String title;
  final String body;
  static int count = 0;
   final int id;

  FullArticle(this.title, this.body,this.id);
  factory FullArticle.fromMap(Map map){
    return FullArticle(map['title'], map['body'], map['id']);
  }
  Map<String,String> toMap(){
    return {title:body};
  }

  @override
  String toString() {
    return 'FullArticle{title: $title, body: $body, id: $id}';
  }
}