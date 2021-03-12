import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:share/share.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:writers_app/created_classes/database.dart';
import 'package:writers_app/created_classes/original_article.dart';
import 'package:writers_app/model/model.dart';
import 'package:writers_app/model/zefyr_model.dart';
import 'package:zefyr/zefyr.dart';

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
    return FutureBuilder<List<Map<String,dynamic>>>(
        future: Provider.of<WritersModel>(context).db.readAllData(),
        builder: (context, snapshot) {
          List<Map> list = snapshot.data;


          listOfTiles = [];
          if (snapshot.hasError) {
            return Text('A little Problem : ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {

            if (snapshot.data.isEmpty) return Scaffold(body: Container());


            final listOfNotus= snapshot.data.map((e) =>
                NotusDocument.fromJson(jsonDecode(e['title']))
            ).toList();
            
            // for(int index = 0;index<listOfNotus.length;index++){
            //   listOfTiles.add(
            //       MyListTile(articleList: articleList, index: index, type: type, article: article)
            //   );
            // }
             List<OriginalArticle> listOfOriginalArticles = snapshot.data.map((e) => OriginalArticle.fromJson(e['title'], e['body'], e['id'])).toList();
            // for(int i=0;i<snapshot.data.length;i++){
            //   int index = i;
            //
            // }
            return ZefyrScaffold(
              child: ListView.builder(
                itemCount: listOfNotus.length,
                  itemBuilder: (_,index){


                    return MyListTile(
                        articleList: listOfOriginalArticles,
                        index: index,
                        listOfTiles: listOfTiles,
                        type: 'local',
                        originalArticle: listOfOriginalArticles[index]
                    );
                return ZefyrField(mode:ZefyrMode.view,
                  controller: ZefyrController(listOfNotus[index]),
                  focusNode: FocusNode(),
                  height: 30,
                );
              }),
            );
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
  MyListTile({Key key,
    @required this.articleList,
    @required this.index,
    this.db,
  @required this.listOfTiles,
    @required this.type,
  @required this.originalArticle,

  })
      : super(key: key);

  final List<OriginalArticle> articleList;
  final int index;
  final MyDatabase db;
  final List<Widget> listOfTiles;
  final String type;
  final OriginalArticle originalArticle;




  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  bool checkable = false;
  bool isChecked = false;
  bool selected = false;


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ViewModel>(context);
    final TabController tabController = DefaultTabController.of(context);
    WritersModel model = Provider.of<WritersModel>(context);
    final controller = ExpandableController();

    return GestureDetector(
      onDoubleTap: () {
        // model.titleController.text = widget.plainArticle.title;
        // model.bodyController.text = widget.plainArticle.body;
        viewModel.bodyController=ZefyrController(widget.originalArticle.body);
        viewModel.titleController=ZefyrController(widget.originalArticle.title);
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
            onTap: () => Share.share('${PlainArticle.fromOriginalArticle(widget.originalArticle)}')
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
                Provider.of<WritersModel>(context,listen: false).deleteSingle(widget.originalArticle);

              }else{
                widget.articleList.removeAt(widget.index);
                final model = Provider.of<WritersModel>(context,listen: false);


                model.deleteArticleFromCloud(widget.originalArticle);

              }
            },
          ),
        ],
        child: MyCard(controller: controller, selected: selected, orginalArticle: widget.originalArticle),

      ),
    );
  }
}

// const loremIpsum =
//     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class MyCard extends StatelessWidget {
final OriginalArticle orginalArticle;
  final ExpandableController controller;
  final bool selected;

  const MyCard({Key key,@required this.controller,@required this.selected,@required this.orginalArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[

                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    controller: controller,
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Container(
                      color: selected?Colors.green:Colors.white70,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ZefyrField(mode:ZefyrMode.view,
                            controller: ZefyrController(orginalArticle.title),
                            focusNode: FocusNode(),
                            height: 25,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                                )
                            ),

                          )
                      ),
                    ),

                    expanded: Container(

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: ZefyrField(mode:ZefyrMode.view,
                                  controller: ZefyrController(orginalArticle.body),
                                  focusNode: FocusNode(),
                                  height: 25,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                    )
                                  ),


                                )),
                        ],
                      ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Expandable(

                        expanded: Container(
                          color: Colors.grey[200],
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              child: expanded,
                            )),
                        theme: const ExpandableThemeData(crossFadePoint: 0),
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