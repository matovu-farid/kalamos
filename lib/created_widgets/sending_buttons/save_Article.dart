import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_classes/FullArticle.dart';
import 'package:writers_app/created_classes/database.dart';
import 'package:writers_app/model/model.dart';
import 'package:writers_app/created_widgets/send_buttons.dart';
class SaveArticle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    return SendButton(
      icon: Icons.save,
      label: 'Save',

      onPressed: () async{
        final title = Provider.of<WritersModel>(context,listen: false).titleController.text;
        final body = Provider.of<WritersModel>(context,listen: false).bodyController.text;
        FullArticle article = FullArticle(title, body);
        MyDatabase db= Provider.of<WritersModel>(context,listen: false).db;
        int row= await db.saveArticle(article);
        print(row);
       //Navigator.of(context).pushNamed('/view');



      },
    );
  }
}
