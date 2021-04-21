import 'package:article_themedata/article_themedata.dart';
import 'package:firebase_wrapper/firebase_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:writers_app/tab_views.dart';
import 'package:articlemodel/articlemodel.dart';
import 'package:articlewidgets/articlewidgets.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';
import 'package:articleclasses/articleclasses.dart' as ac;

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
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    //Provider.of<WritersModel>(context, listen: false).initApp(ac.App.Writer);
    return FirebaseWrapper(child: TheApp());
  }
}

class TheApp extends StatelessWidget {
  const TheApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<WritersModel>(context, listen: false).initApp(ac.App.Writer);
    return LitAuthInit(
      authProviders: AuthProviders(google: true, emailAndPassword: false),
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
    return ZefyrScaffold(
      child: MaterialApp(
        theme: buildArticlesThemeData(context),
        routes: {
          '/': (_) => MyHomePage(title: 'Shories'),
          '/Profile': (_) => Profile(),
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
  String firstTimeKey = 'first time';
  bool isFirstTime = false;

  Future<void> getIsFirstTime() async {
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(firstTimeKey)) {
      isFirstTime= true;
      prefs.setBool(firstTimeKey,false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: getIsFirstTime(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done)


            if(isFirstTime) {

              return SetupPage(
                switchCallBack: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TabViews()));
                },
              );
            }
          return TabViews();

        }
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

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
