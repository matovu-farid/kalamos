import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite/sqflite.dart';
import 'package:writers_app/color_button.dart';
import 'package:writers_app/created_widgets/view.dart';
import 'created_widgets/article/article_body.dart';
import 'created_widgets/authenticated.dart';
import 'package:writers_app/created_widgets/unauthenticated.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:writers_app/model/model.dart';

import 'created_widgets/send.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider<WritersModel>(
      create: (_) => WritersModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            //return TheApp();
            return TheApp();
          }
          return Loading();
        });
  }
}

class TheApp extends StatelessWidget {
  const TheApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      authProviders: AuthProviders(google: true),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (_) => MyHomePage(title: 'Writers App'),
          '/body': (_) => Body(maxLines: 1000, title: 'Writers App'),
          '/send': (_) => SendArticle(title: 'Writers App'),
          '/view':(_)=>ViewArticle(title: 'Writers App')
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final maxLines = 25;

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        drawer: Drawer(
            child: Column(children: <Widget>[
          AppBar(),
          FlatButton(
            shape: RoundedRectangleBorder(),
            child: Text(
              'Sign out',
            ),
            onPressed: () {
              Provider.of<WritersModel>(context, listen: false).signout();
            },
          )
        ])),

        body: LitAuthState(
          authenticated: Authenticated(
            width: width,
            height: height,
            maxLines: maxLines,
          ),
          unauthenticated: Unauthenticated(),
        ));
  }
}


class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text('Some thing went wrong'))),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text('Loading'))),
    );
  }
}
