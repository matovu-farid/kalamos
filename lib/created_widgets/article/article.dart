import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:writers_app/model/model.dart';
import 'package:zefyr/zefyr.dart';
class ArticleInput extends StatelessWidget {
   ArticleInput(
      {Key key,
        @required this.maxLines,
        @required this.labelText,
        @required this.controller,
        this.isBordered=true
      })
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final int maxLines;
  bool isBordered;

  @override
  Widget build(BuildContext context) {
    return Consumer<WritersModel>(builder: (context, model, child) {

      return TextField(

        controller: controller,
        cursorColor: model.selectedColor,
        style: TextStyle(color: model.selectedColor),
        //autofocus: false,
        decoration: isBordered ? InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ))) :InputDecoration(
          labelText: labelText
        ),
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
      );
    });
  }
}