import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:writers_app/model/model.dart';

class ShareWidget extends StatelessWidget {
  const ShareWidget({
    Key key, this.color,this.textColor
      }) : super(key: key);

  final Color color;
  final textColor;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Share',style: TextStyle(color: textColor),),
          Icon(Icons.share,color: textColor,),
        ],
      ),

      onPressed: () {
        final titleController = Provider.of<WritersModel>(context,listen: false).titleController;
        final bodyController = Provider.of<WritersModel>(context,listen: false).bodyController;
        Share.share('\t\t ${titleController.text}\n\n '
            '${bodyController.text}');
      },
    );
  }
}
