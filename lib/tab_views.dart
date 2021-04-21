import 'package:articlewidgets/articlewidgets.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'created_widgets/authenticated.dart';
import 'created_widgets/unauthenticated.dart';

class TabViews extends StatelessWidget {
  const TabViews({
    Key key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;
      final maxLines = 25;

      return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Center(
                    child: Text(
                  'Writaz',
                  style: Theme.of(context).textTheme.headline3,
                )),
              ),
              bottom: TabBar(tabs: [
                Tab(
                  child: Text('Write'),
                ),
                Tab(
                  child: Text('View'),
                ),
                Tab(
                  child: Text('Uploaded'),
                ),
                // Tab(child:Text('Profile'))
              ]),
            ),
            drawer: MyDrawer(),
            body: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/coffee-min.jpg'),
                    fit: BoxFit.cover),
              ),
              child: LitAuthState(
                authenticated: Authenticated(
                  width: width,
                  height: height,
                  maxLines: maxLines,
                ),
                unauthenticated: Unauthenticated(),
              ),
            )),
      );
    });
  }
}
