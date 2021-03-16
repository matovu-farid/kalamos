// import 'dart:convert';
//
// import 'package:articleclasses/articleclasses.dart';
// import 'package:articlewidgets/articlewidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:zefyr/zefyr.dart';
//
// //db.re
//
// class ViewArticles extends StatelessWidget {
//
// ViewArticles(this.future);
//   List<Widget> listOfTiles ;
//
//
//   final Future<List<Map<String,dynamic>>> future;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String,dynamic>>>(
//         future: future,
//         builder: (context, snapshot) {
//           List<Map> list = snapshot.data;
//           listOfTiles = [];
//           if (snapshot.hasError) {
//             return Text('A little Problem : ${snapshot.error}');
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//
//             if(snapshot.hasData&&snapshot.data!=null){
//             final listOfNotus= snapshot.data.map((e) =>
//                 NotusDocument.fromJson(jsonDecode(e['title']))
//             ).toList();
//              List<OriginalArticle> listOfOriginalArticles = snapshot.data.map((e) => OriginalArticle.fromJson(e['title'], e['body'], e['id'])).toList();
//
//             return ZefyrScaffold(
//               child: ListView.builder(
//                 itemCount: listOfNotus.length,
//                   itemBuilder: (_,index){
//                     return MyListTile(
//                         articleList: listOfOriginalArticles,
//                         index: index,
//                         listOfTiles: listOfTiles,
//                         type: 'local',
//                         originalArticle: listOfOriginalArticles[index]
//                     );
//
//               }),
//             );}
//             return Scaffold(body: Container());
//           }
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                   width: 50, height: 50, child: CircularProgressIndicator()),
//             ),
//           );
//         });
//   }
// }


