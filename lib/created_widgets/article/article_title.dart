import 'package:articlemodel/articlemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:articlewidgets/articlewidgets.dart';

class ArticleTitle extends StatelessWidget {
  const ArticleTitle({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InputField(
      maxLines: 2,
      labelText: 'Title',
      controller: Provider.of<WritersModel>(context).titleController,
    );
  }
}