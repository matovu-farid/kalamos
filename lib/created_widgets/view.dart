import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_classes/database.dart';
import 'package:writers_app/model/model.dart';
class ViewArticle extends StatelessWidget {
  final String title;

  const ViewArticle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyDatabase db= Provider.of<WritersModel>(context).db;
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: FutureBuilder<List<Map<String,String>>>(
        future: db.readAllData(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length,

              itemBuilder: (context,index){
                return Row(
                  children: [
                    Text(snapshot.data[index].entries.first.key),

                    Text(snapshot.data[index].entries.first.value),
                  ],
                );
              });
        }
      ),
    );
  }
}
