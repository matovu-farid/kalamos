import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_widgets/sending_buttons/save_Article.dart';
import 'package:writers_app/model/model.dart';
import 'sending_buttons/share.dart';
import './sending_buttons/view_button.dart';


class Uploaded extends StatelessWidget{
  final color = Colors.blueGrey;
  final textColor = Colors.white70;

  const Uploaded({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder(
        future: Provider.of<WritersModel>(context,listen: false).fetchFromFirestore(),
        builder: (context, snapshot) {
         final articlesFetched =  Provider.of<WritersModel>(context,listen: false).articlesFetched;
         if(snapshot.hasError) return Text('Error got : ${snapshot.error}');
         if(snapshot.connectionState==ConnectionState.done)
          return ListView.builder(
            itemCount: articlesFetched.length,
              itemBuilder: (context,index){

                return ListTile(title: Text(articlesFetched[index].title),);

              });
         return SizedBox(
             width: 50,
             height: 50,
             child: FittedBox(child: CircularProgressIndicator()));
        }
      ),
    );
  }}