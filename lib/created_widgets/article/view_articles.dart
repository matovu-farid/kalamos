import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:writers_app/created_classes/database.dart';
import 'package:writers_app/model/model.dart';

class ViewArticles extends StatelessWidget {
  ViewArticles({
    Key key,
    @required this.db,
   // @required this.listOfTiles,
  }) : super(key: key);

  final MyDatabase db;
  List<Widget> listOfTiles ;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map>>(
        future: Provider.of<WritersModel>(context).db.readAllData(),
        builder: (context, snapshot) {
          List<Map> list = snapshot.data;
          listOfTiles = [];
          if (snapshot.hasError) {
            return Text('A little Problem : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.isEmpty) return Scaffold(body: Container());
            List<Map> typedList = list
                .map((e) => {
                      'id':int.parse(e['id'].toString()),
                      'title': e['title'].toString(),
                      'body': e['body'].toString()
                    })
                .toList();
           // print(typedList);
             List<FullArticle> articleList= typedList.map((e) => FullArticle.fromMap(e)).toList();
            for (var i = 0; i < articleList.length; i++) {
              int index = i;
              final article = articleList[i];
              listOfTiles.add(MyListTile(articleList: articleList, index: index,db:db,listOfTiles: listOfTiles,type:'local',article: article,));
            }
            return ListView(
              children: [
                ...listOfTiles,
                SizedBox(
                  height: 50,
                )
              ],
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
  MyListTile({Key key, @required this.articleList, @required this.index, this.db, this.listOfTiles, @required this.type, @required this.article})
      : super(key: key);

  final List<FullArticle> articleList;
  final int index;
  final MyDatabase db;
  final List<Widget> listOfTiles;
  final String type;
  final FullArticle article;


  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  bool checkable = false;
  bool isChecked = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);
    WritersModel model = Provider.of<WritersModel>(context);
    final controller = ExpandableController();

    return GestureDetector(
      onDoubleTap: () {
        model.titleController.text = (widget.articleList[widget.index]).title;
        model.bodyController.text = (widget.articleList[widget.index]).body;
        tabController.animateTo(0);
      },

      onLongPress: (){
        setState(() {
          selected =!selected;
          print(widget.index);

          Provider.of<WritersModel>(context, listen: false).onLongPress(widget.index, selected, widget.articleList,widget.type);

        });
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () => {},
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => Share.share('${widget.article}')
            ,
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => {},
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: ()  {
             // widget.listOfTiles.removeAt(widget.index);
              if(widget.type=='local') {
                Provider.of<WritersModel>(context,listen: false).deleteSingle(widget.article);

              }else{
                widget.articleList.removeAt(widget.index);
                final model = Provider.of<WritersModel>(context,listen: false);


                model.deleteArticleFromCloud(widget.article);

                //widget.listOfTiles.removeAt(widget.index);
              }






            },
          ),
        ],
        child: MyCard(
          selected: selected,
            title: widget.article.title,body: widget.article.body,controller:controller),

      ),
    );
  }
}

// const loremIpsum =
//     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class MyCard extends StatelessWidget {
  final String title;
  final String body;
  final ExpandableController controller;
  final bool selected;

  const MyCard({Key key, this.title, this.body, this.controller, this.selected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                // SizedBox(
                //   height: 150,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.orange,
                //       shape: BoxShape.rectangle,
                //     ),
                //   ),
                // ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    controller: controller,
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.body2,
                        )),
                    collapsed: Text(
                      body,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                         // for (var _ in Iterable.generate(5))
                            Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  body,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                )),
                        ],
                      ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Container(
                        color: selected?Colors.green:Colors.white70,
                        child: Expandable(

                          collapsed: Padding(padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: collapsed),
                          expanded: Container(
                            color: Colors.grey[200],
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                child: expanded,
                              )),
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}