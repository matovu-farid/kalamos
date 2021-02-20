import 'package:flutter/material.dart';

class Authenticated extends StatelessWidget {
  const Authenticated({
    Key key,
    @required this.width,
    @required this.height,
    @required this.titleController,
    @required this.maxLines,
    @required this.bodyController,
  }) : super(key: key);

  final double width;
  final double height;
  final TextEditingController titleController;
  final int maxLines;
  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    ));
  }
}
