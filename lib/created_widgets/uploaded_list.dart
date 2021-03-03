import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/model/model.dart';

import 'article/view_articles.dart';

class UploadedList extends StatelessWidget {


   List<Widget> listOfTiles=[];


   Future fetchFromCloud(BuildContext context)async{
     final model =  Provider.of<WritersModel>(context, listen: false);

     if(model.articlesFetched.isEmpty)await model.fetchFromFirestore();

     return model.articlesFetched;
   }
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WritersModel>(context, listen: true);

    return Center(
      child: FutureBuilder(
          future: Provider.of<WritersModel>(context).fetchFromFirestore(),
          builder: (context, snapshot) {
            listOfTiles=[];

            final articlesFetched = model.articlesFetched;
            if (snapshot.hasError) return Text('Error got : ${snapshot.error}');
            if (snapshot.connectionState == ConnectionState.done){
              for (int i = 0; i < articlesFetched.length; i++) {
               final  article = articlesFetched[i];

               listOfTiles.add(MyListTile(
                 article: article,
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
