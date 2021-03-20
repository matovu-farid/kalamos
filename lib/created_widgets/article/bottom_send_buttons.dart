import 'package:articlemodel/articlemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSendButtons extends StatelessWidget {
  const BottomSendButtons({
    Key key,@required this.type
  }) : super(key: key);
final String type;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if(type=='local')
          ViewButton(
            text: 'Upload',
            onPressed:()async{

              await Provider.of<WritersModel>(context, listen: false).upLoadMultipleArticles(context,'writers');


            }),
        DeleteButton(type: type),
      ],
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key key,
    @required this.type,
     this.index
  }) : super(key: key);

  final String type;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ViewButton(
        text: 'Delete',
        onPressed: (){
          if(type=='local') Provider.of<WritersModel>(context, listen: false).deleteFromCache('WriterTable');
          else Provider.of<WritersModel>(context, listen: false).deleteMultipleFromCloud();
        }
    );
  }
}

class ViewButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ViewButton({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: 'View$text', onPressed: onPressed, label: Text(text));
  }
}