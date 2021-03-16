// import 'package:articlemodel/articlemodel.dart';
// import 'package:flutter/material.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:provider/provider.dart';
// import 'package:zefyr/zefyr.dart';
// import 'package:articlewidgets/articlewidgets.dart';
//
// class CloudList extends StatelessWidget {
//
//
//    List<Widget> listOfTiles=[];
//
//
//
//    final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();
//   @override
//   Widget build(BuildContext context) {
//     final model = Provider.of<WritersModel>(context, listen: true);
//
//     return Center(
//       child: StreamBuilder(
//           stream: Provider.of<WritersModel>(context).fetchFromFirestore().asStream(),
//           builder: (context, snapshot) {
//             listOfTiles=[];
//
//             final articlesFetched = snapshot.data;
//             if (snapshot.hasError) return Text('Error got : ${snapshot.error}');
//             if (snapshot.hasData){
//               for (int i = 0; i < articlesFetched.length; i++) {
//                final  article = articlesFetched[i]..index=i;
//
//
//                listOfTiles.add(MyListTile(
//                  originalArticle: article,
//                     articleList: articlesFetched,
//                     index: i,
//                     listOfTiles: listOfTiles,
//                     type: 'cloud'));
//               }
//             return LiquidPullToRefresh(
//               key: _refreshIndicatorKey,
//               onRefresh:()=> model.fetchFromFirestore(fetch: true),
//               child: ZefyrScaffold(
//                 child: ListView(
//                   children: [...listOfTiles],
//                 ),
//               ),
//             );}
//               return CircularProgressIndicator();
//           }),
//     );
//   }
// }
