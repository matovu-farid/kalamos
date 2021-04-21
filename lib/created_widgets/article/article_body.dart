import 'dart:convert';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:articleclasses/articleclasses.dart';
import 'package:articlemodel/articlemodel.dart';
import 'package:articlewidgets/articlewidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_widgets/speach_to_text_widget.dart';
import 'package:shared_widgets/shared_widgets.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:zefyr/zefyr.dart';

class WriteArticle extends StatefulWidget {
  const WriteArticle({
    Key key,

  }) : super(key: key);

  @override
  _WriteArticleState createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle> {






  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double editorHeight = screenHeight * 0.6;

    ViewModel viewModel = Provider.of<ViewModel>(context,listen: false);
    WritersModel writerModel = Provider.of<WritersModel>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.white,

      body: ZefyrScaffold(
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Consumer<WritersModel>(
                    builder: (context,model,child) {
                      return ZefyrTheme(
                        data: ZefyrThemeData.fallback(context).copyWith(
                            defaultLineTheme: LineTheme(
                              textStyle: model.style,
                              padding: EdgeInsets.all(5),
                            )

                        ),
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

                              imageDelegate: MyAppZefyrImageDelegate(),
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
                      );
                    }
                  ),
                )),

            Align(
              alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    ChangeFonts(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpeechWidget(),
                    ),


                    Consumer<WritersModel>(
                      builder:(_,model,child)=>
                        LocalSaveButton(viewModel: viewModel,writersModel: model,),

                    ),
                  ],
                )),


          ],
        ),
      ),
    );
  }
}



class LocalSaveButton extends StatefulWidget {
  LocalSaveButton({
    Key key,
    @required this.viewModel, this.writersModel,
  }) : super(key: key);

  final ViewModel viewModel;
  final WritersModel writersModel;

  @override
  _LocalSaveButtonState createState() => _LocalSaveButtonState();
}

class _LocalSaveButtonState extends State<LocalSaveButton> with SingleTickerProviderStateMixin{
  void _saveDocument(BuildContext context,WritersModel model,ViewModel viewModel) {
    final model = Provider.of<WritersModel>(context,listen: false);


    final body = viewModel.bodyController.document;
    final title = viewModel.titleController.document;

    final database = MyDatabase(model.writerTable, model.writerPic);
    var encordedTitle= jsonEncode(title.toJson());
    var encordedBody= jsonEncode(body.toJson());
    encap(encordedBody);
    if(title.toPlainText()!=''&&title.toPlainText()!=null)
      database.saveArticle2(PlainArticle(encordedTitle, encordedBody, 0));
  }
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 2));

  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopAnimation(
      animationController: _animationController,
      child: FloatingActionButton(
        heroTag: 'save article',
          onPressed: (){
            _saveDocument(context,widget.writersModel,widget.viewModel);
            _animationController.forward();
          },
        child: JumpAnimation(child: Icon(Icons.save)),
      ),
    );
  }
}


