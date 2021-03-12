import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:writers_app/color_button.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:writers_app/created_widgets/sending_buttons/save_Article.dart';
import 'package:writers_app/model/model.dart';
import 'package:writers_app/model/zefyr_model.dart';
import 'package:zefyr/zefyr.dart';
import 'article.dart';

class WriteArticle extends StatefulWidget {
  const WriteArticle({
    Key key,

  }) : super(key: key);

  @override
  _WriteArticleState createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {



  // @override
  // void initState() {
  //   super.initState();
  //   _titleController = ZefyrController(loadDocument());
  //   _bodyController = ZefyrController(loadDocument());
  //   _titleFocusNode = FocusNode();
  //   _bodyFocusNode = FocusNode();
  // }
  // @override
  // void dispose() {
  //   super.dispose();
  //
  // }
  void _saveDocument(BuildContext context,WritersModel model,ViewModel viewModel) {

  final body = viewModel.bodyController.document;
  final title = viewModel.titleController.document;
   final database = model.db;
    var encordedTitle= jsonEncode(title.toJson());
    var encordedBody= jsonEncode(body.toJson());
    //print("$encordedTitle");
    database.saveArticle2(PlainArticle(encordedTitle, encordedBody, 0));
   //database.saveArticle(FullArticle(encordedTitle, encordedBody, 0));
    //database.saveZefyrDoc(encordedTitle, encordedBody);

  }



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double editorHeight = screenHeight * 0.6;

    ViewModel viewModel = Provider.of<ViewModel>(context,listen: false);

    return ZefyrScaffold(
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ZefyrField(
                      height: 30,
                      controller: viewModel.titleController,
                      focusNode: viewModel.titleFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Enter Title Here...',

                      ),
                    ),
                    SizedBox(height: 10,),
                    ZefyrField(
                      height: editorHeight, // set the editor's height
                      controller: viewModel.bodyController,
                      focusNode: viewModel.bodyFocusNode,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Enter body Here...',

                      ),
                      physics: ClampingScrollPhysics(),
                    )
                  ],
                ),
              )),
          Align(
            alignment: Alignment.bottomRight,
              child: Consumer<WritersModel>(
                builder:(_,model,child)=> FloatingActionButton(

                    onPressed: ()=>_saveDocument(context,model,viewModel),
                  child: Icon(Icons.save),
                ),
              ))
        ],
      ),
    );
  }
}
