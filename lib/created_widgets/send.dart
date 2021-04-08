import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_widgets/article/bottom_send_buttons.dart';
import 'package:articlewidgets/articlewidgets.dart';
import 'package:articlemodel/articlemodel.dart';


class Uploaded extends StatelessWidget {
  final color = Colors.blueGrey;
  final textColor = Colors.white70;
  WriterArticleBloc writerBloc = WriterArticleBloc();

  Uploaded({Key key}) : super(key: key);
  List<Widget> listOfTiles;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CloudList(
          stream:  writerBloc.fetchArticleStreamFromFirestore(),

        ),
        Align(
          alignment: Alignment.bottomRight,
            child: DeleteButton(type: 'cloud',))
      ],
    );
  }
}
