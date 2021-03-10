import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:writers_app/color_button.dart';
import 'package:writers_app/created_widgets/sending_buttons/save_Article.dart';
import 'package:writers_app/model/model.dart';
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
  ZefyrController _controller;
  FocusNode _focusNode;

  NotusDocument loadDocument(){
    final _delta =  Delta()..insert('Body\n');
   return NotusDocument.fromDelta(_delta);

  }

  @override
  void initState() {
    super.initState();
    _controller = ZefyrController(loadDocument());
    _focusNode = FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        SizedBox.expand(
          child: Column(
            children: [
              ArticleInput(maxLines: 1, labelText: 'title',
                  controller: Provider.of<WritersModel>(context).titleController),
              Flexible(
                child: ZefyrScaffold(
                    child:ZefyrEditor(controller: _controller,focusNode: _focusNode,)
                ),
                // child: ArticleInput(
                //   maxLines: 100000,
                //   labelText: 'Body',
                //   controller: Provider.of<WritersModel>(context).bodyController,
                // ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
            child: SaveArticle())
      ],
    );
  }
}
