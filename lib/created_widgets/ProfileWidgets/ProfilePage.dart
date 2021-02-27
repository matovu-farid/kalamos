import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_classes/writer_profile.dart';
import 'package:writers_app/created_widgets/article/article.dart';
import 'package:writers_app/model/model.dart';
class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     WritersModel model= Provider.of<WritersModel>(context);
    model.initializeName();
    return Scaffold(
      appBar: AppBar(),
        body: Center(
          child:ListView(
            children: [
              Container(
                height: 180,
                child: Placeholder(

                ),
              ),
              ArticleInput(maxLines: 1, labelText: 'Name', controller: model.nameController)
            ],
          )
        ));
  }
}
