import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:writers_app/model/model.dart';

void main() {
  runApp(ChangeNotifierProvider<WritersModel>(
      create: (_) => WritersModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Writers App'),
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
  String get articleTitle => titleController.text;
  String get articleBody => bodyController.text;
  TextEditingController titleController;
  TextEditingController bodyController;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    bodyController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final maxLines = 25;
    return Scaffold(
      floatingActionButton: Container(
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildColorButton(context),
            buildShareButton(),
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: width,
          height: height,
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ArticleInput(
                      maxLines: 2,
                      labelText: 'Title',
                      controller: titleController,
                    ),
                  )),
              Flexible(
                  flex: 8,
                  child: ArticleInput(
                    maxLines: maxLines,
                    labelText: 'Body',
                    controller: bodyController,
                  )),
            ],
          ),
        ),
      )),
    );
  }

  FloatingActionButton buildShareButton() {
    return FloatingActionButton(
      child: Icon(Icons.share),
      onPressed: () {
        Share.share('\t\t ${titleController.text}\n\n ${bodyController.text}');
      },
    );
  }
}

class ArticleInput extends StatelessWidget {
  const ArticleInput(
      {Key key,
      @required this.maxLines,
      @required this.labelText,
      @required this.controller})
      : super(key: key);

  final int maxLines;
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<WritersModel>(builder: (context, model, child) {
      return TextField(
        controller: controller,
        cursorColor: model.selectedColor,
        style: TextStyle(color: model.selectedColor),
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(30),
            ))),
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
      );
    });
  }
}

FloatingActionButton buildColorButton(
  BuildContext context,
) {
  return FloatingActionButton(
    onPressed: () {
      var pickerColor =
          Provider.of<WritersModel>(context, listen: false).pickerColor;
      var selectedColor =
          Provider.of<WritersModel>(context, listen: false).selectedColor;
      final changeColor =
          Provider.of<WritersModel>(context, listen: false).changeColor;
      showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Got it'),
              onPressed: () {
                selectedColor = pickerColor;
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      Toast.show('Pick a color', context);
    },
    tooltip: 'choose color',
    child: Icon(
      FontAwesomeIcons.dashcube,
    ),
  );
}
