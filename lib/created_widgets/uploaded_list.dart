import 'package:animated_stream_list/animated_stream_list.dart';
import 'package:articleclasses/articleclasses.dart';
import 'package:articlemodel/articlemodel.dart';
import 'package:articlewidgets/articlewidgets.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';
class CloudList extends StatefulWidget {
  CloudList({Key key}) : super(key: key);

  @override
  _CloudListState createState() => _CloudListState();
}


class _CloudListState extends State<CloudList> {
  //List<Widget> listOfTiles=[];
  Widget itembuilder (article,index,context, animation) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: MyListTile(
        tab:WriterTab.upload,
        isFromReader: false,
        originalArticle: article,),
    );
  }


  WriterArticleBloc writerBloc = WriterArticleBloc();
  Widget _createTile(Widget widget, Animation<double> animation) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: widget,
    );


  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WritersModel>(context, listen: true);
    var stream = writerBloc.fetchArticleStreamFromFirestore();
    model.initCloudBloc();
    return Center(
        child: ZefyrScaffold(
          child: AnimatedStreamList<OriginalArticle>(
            itemRemovedBuilder:itembuilder,
            streamList:  stream,
            itemBuilder: itembuilder,
          ),
        ));
  }
}