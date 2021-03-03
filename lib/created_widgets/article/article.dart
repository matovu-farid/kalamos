import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/model/model.dart';
class ArticleInput extends StatelessWidget {
  const ArticleInput(
      {Key key,
        @required this.maxLines,
        @required this.labelText,
        @required this.controller
      })
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Consumer<WritersModel>(builder: (context, model, child) {

      return TextField(

        controller: controller,
        cursorColor: model.selectedColor,
        style: TextStyle(color: model.selectedColor),
        //autofocus: false,
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