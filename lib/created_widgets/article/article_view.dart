import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:writers_app/created_classes/database.dart';


class ViewArticles extends StatefulWidget {
  ViewArticles({Key key}) : super(key: key);

  @override
  _ViewArticlesState createState() => _ViewArticlesState();
}

class _ViewArticlesState extends State<ViewArticles> {
  ExpandedTileController _expandedController;
 @override
  void initState() {
   _expandedController = ExpandedTileController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    MyDatabase db = MyDatabase();

    return FutureBuilder<List<Map>>(
        future: db.readAllData(),
        builder: (context, snapshot) {
          List<Map> list = snapshot.data;
          if (snapshot.hasError) {
            return Text('A little Problem : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.isEmpty) return Scaffold(body: Container());
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  List<Map<String, String>> typedList = list
                      .map((e) => {
                            'title': e['title'].toString(),
                            'body': e['body'].toString()
                          })
                      .toList();

                  return Card(
                    child: ExpandedTile(
                      title: Text((typedList[index])['title']),
                       content: Text((typedList[index])['body']),
                       controller: ExpandedTileController()
                    ),
                  );
                });
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                  height: 50,
                  child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
