import 'dart:convert';

import 'package:articleclasses/articleclasses.dart';
import 'package:articlemodel/articlemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_widgets/speach_to_text_widget.dart';


import 'package:zefyr/zefyr.dart';

class WriteArticle extends StatefulWidget {
  const WriteArticle({
    Key key,

  }) : super(key: key);

  @override
  _WriteArticleState createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {


  void _saveDocument(BuildContext context,WritersModel model,ViewModel viewModel) {

  final body = viewModel.bodyController.document;
  final title = viewModel.titleController.document;
   final database = MyDatabase('WriterTable', 'WriterPic');
    var encordedTitle= jsonEncode(title.toJson());
    var encordedBody= jsonEncode(body.toJson());
    database.saveArticle2(PlainArticle(encordedTitle, encordedBody, 0));
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
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ZefyrField(
                      height: 40,
                      physics: ClampingScrollPhysics(),
                      autofocus: false,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SpeechWidget(),
                  ),


                  Consumer<WritersModel>(
                    builder:(_,model,child)=> FloatingActionButton(
                      heroTag: 'save article',
                        onPressed: ()=>_saveDocument(context,model,viewModel),
                      child: Icon(Icons.save),
                    ),
                  ),
                ],
              )),


        ],
      ),
    );
  }
}
