import 'package:avatar_glow/avatar_glow.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_classes/writer_profile.dart';
import 'package:writers_app/created_widgets/article/article.dart';
import 'package:writers_app/model/model.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WritersModel model = Provider.of<WritersModel>(context);
    model.initializeName();
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: ListView(
          children: [
            Consumer<WritersModel>(
              builder: (_, model, child) {
                if (model.image != null) {
                  return GestureDetector(
                    child: AvatarGlow(
                      endRadius: 120,
                      glowColor: Colors.blueGrey,
                      child: Material(
                        elevation: 8.0,

                        shape: CircleBorder(),
                        child: CircularProfileAvatar('',
                            borderWidth: 5,
                            elevation: 2,
                          radius: 100,
                          child: Image.file(model.image)

                        ),
                      ),
                    ),
                    onTap: () async{
                      await model.setProfilePic();
                    },
                  );
                } else
                  return GestureDetector(
                    onTap: ()async{
                      await model.setProfilePic();
                    },
                    child: CircularProfileAvatar('',
                      backgroundColor: Colors.grey,
                      radius: 100,
                      child: Container(
                        height: 120,
                        width: 120,
                        color: Colors.grey,

                      ),
                    ),
                  );
              },

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ArticleInput(
                  maxLines: 1,
                  labelText: 'Name',
                  controller: model.nameController),
            )
          ],
        )));
  }
}
