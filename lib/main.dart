import 'package:articlemodel/articlemodel.dart';
import 'package:articlewidgets/articlewidgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:profile_page/profile_page.dart';

import 'created_widgets/authenticated.dart';
import 'package:writers_app/created_widgets/unauthenticated.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:profile_page/profile_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WritersModel>(create: (_) => WritersModel()),
      ChangeNotifierProvider<ViewModel>(create: (_) => ViewModel()),
    ],
    child: MyApp(),

  ));
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
      child: LayoutBuilder(builder: (context, constraints) {
        //if(constraints.maxHeight>900) return RotatedBox(quarterTurns: 1,child: ConstantMaterialApp());
        //else
        return ConstantMaterialApp();
      }),
    );
  }
}

class ConstantMaterialApp extends StatelessWidget {
  const ConstantMaterialApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (_) => MyHomePage(title: 'Shories'),
        '/Profile': (_) => ProfilePage(),
      },
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


    return DefaultTabController(

      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
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
          body: LitAuthState(
            authenticated: Authenticated(
              width: width,
              height: height,
              maxLines: maxLines,
            ),
            unauthenticated: Unauthenticated(),
          )),
    );
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
      home: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
