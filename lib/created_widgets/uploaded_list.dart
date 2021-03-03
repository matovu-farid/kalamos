import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/model/model.dart';

import 'article/view_articles.dart';

class UploadedList extends StatelessWidget {
   UploadedList({
    Key key,

  }) : super(key: key);

   //List<Widget> listOfTiles=[];

   List<Widget> listOfTiles;
  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder(
          future: Provider.of<WritersModel>(context, listen: false).fetchFromFirestore(),
          builder: (context, snapshot) {
            listOfTiles = [];
            final articlesFetched =
                Provider.of<WritersModel>(context, listen: false)
                    .articlesFetched;
            if (snapshot.hasError) return Text('Error got : ${snapshot.error}');
            if (snapshot.connectionState == ConnectionState.done){
              for (int i = 0; i < articlesFetched.length; i++) {

                listOfTiles.add(MyListTile(
                    articleList: articlesFetched,
                    index: i,
                    listOfTiles: listOfTiles,
                    type: 'cloud'));
              }
            return ListView(
              children: [...listOfTiles],
            );}
              return CircularProgressIndicator();
          }),
    );
  }
}
