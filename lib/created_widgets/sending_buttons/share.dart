import 'package:articlemodel/articlemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../send_buttons.dart';

class ShareWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SendButton(
      label: 'Share',
      icon: Icons.share,
      onPressed: (){
        final titleController = Provider.of<WritersModel>(context,listen: false).titleController;
        final bodyController = Provider.of<WritersModel>(context,listen: false).bodyController;
        Share.share('\t\t ${titleController.text}\n\n '
            '${bodyController.text}');
      },
    );
  }
}
