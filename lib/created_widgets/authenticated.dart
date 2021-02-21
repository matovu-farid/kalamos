import 'package:flutter/material.dart';

import 'article/article_title.dart';


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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              minWidth: MediaQuery.of(context).size.width,
                onPressed: (){
                showDialog(context: context,
                  builder: (_){
                  return AlertDialog(
                    title: Text('Enter a title'),
                    content: ArticleTitle(),
                    actions: [
                      FlatButton(onPressed: () {
                        Navigator.of(context).pushNamed('/body');
                      },
                      child: Text('Next')),
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                  }
                );
                },
                color: Colors.purple,
                child: Text('Write a new article',style: TextStyle(color: Colors.white),)
            ),
          FlatButton(onPressed: (){},
              minWidth: MediaQuery.of(context).size.width,
                color: Colors.purple,
                child: Text('View saved articles',style: TextStyle(color: Colors.white),)
            ),

          ],
        ),
      ),
    ));
  }
}


