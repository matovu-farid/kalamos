import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_classes/database.dart';
import 'package:writers_app/model/model.dart';

class ViewArticles extends StatelessWidget {
  const ViewArticles({
    Key key,
    @required this.db,
    @required this.listOfTiles,
  }) : super(key: key);

  final MyDatabase db;
  final List<Widget> listOfTiles;

  @override
  Widget build(BuildContext context) {


    return FutureBuilder<List<Map>>(
        future: db.readAllData(),
        builder: (context, snapshot) {
          List<Map> list = snapshot.data;
          if (snapshot.hasError) {
            return Text('A little Problem : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.isEmpty) return Scaffold(body: Container());
            List<Map<String, String>> typedList = list
                .map((e) => {
                      'title': e['title'].toString(),
                      'body': e['body'].toString()
                    })
                .toList();
            for (var i = 0; i < typedList.length ; i++) {
              int index = i;
              listOfTiles.add(MyListTile(typedList: typedList, index: index));
            }
            return ListView(
              children: [...listOfTiles],
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()),
            ),
          );
        });
  }
}

class MyListTile extends StatefulWidget {
  MyListTile({Key key, @required this.typedList, @required this.index})
      : super(key: key);

  final List<Map<String, String>> typedList;
  final int index;

  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  bool checkable = false;

  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);
     WritersModel model= Provider.of<WritersModel>(context);
    return GestureDetector(
      onDoubleTap: (){
        model.titleController.text = (widget.typedList[widget.index])['title'];
        model.bodyController.text = (widget.typedList[widget.index])['body'];
        tabController.animateTo(0);
      },
      child: Card(
        child: ExpandedTile(
            checkable: true,
            onChecked: (isChecked) {
              Provider.of<WritersModel>(context, listen: false)
                  .onChecked(widget.index, isChecked, widget.typedList);
            },
            title: Text((widget.typedList[widget.index])['title']),
            content: Text((widget.typedList[widget.index])['body']),
            controller: ExpandedTileController()),
      ),
    );
  }
}