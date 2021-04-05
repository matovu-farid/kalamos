import 'package:articleclasses/articleclasses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_widgets/article/bottom_send_buttons.dart';
import 'package:articlewidgets/articlewidgets.dart';
import 'package:articlemodel/articlemodel.dart';
class ViewArticlesPage extends StatefulWidget {
  ViewArticlesPage({Key key}) : super(key: key);

  @override
  _ViewArticlesPageState createState() => _ViewArticlesPageState();
}

class _ViewArticlesPageState extends State<ViewArticlesPage> {
  //List<Widget> listOfTiles = [];


  @override
  Widget build(BuildContext context) {
     final model = Provider.of<WritersModel>(context);
    MyDatabase db = MyDatabase(model.writerTable, model.writerPic);

    return Stack(
      children: [

        ViewArticles(
          db.readAllData()
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomSendButtons(type:'local'),
          ),
        )
      ],
    );
  }
}


