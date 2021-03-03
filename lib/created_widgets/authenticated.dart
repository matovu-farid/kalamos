import 'package:flutter/material.dart';
import 'package:writers_app/created_widgets/send.dart';

import 'article/article_body.dart';
import 'article/article_title.dart';
import 'article/article_view.dart';
import 'package:writers_app/created_widgets/ProfileWidgets/ProfilePage.dart';


class Authenticated extends StatelessWidget {
  const Authenticated({
    Key key,
    @required this.width,
    @required this.height,
    @required this.maxLines,
  }) : super(key: key);

  final double width;
  final double height;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: width,
        height: height,
        child: TabBarView(

          children: [
            WriteArticle(),
            ViewArticlesPage(),
            Uploaded(),
            //ProfilePage()


          ],
        )
      ),
    ));
  }
}


