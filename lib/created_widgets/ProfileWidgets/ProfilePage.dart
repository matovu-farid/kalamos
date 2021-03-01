import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_classes/writer_profile.dart';
import 'package:writers_app/created_widgets/article/article.dart';
import 'package:writers_app/model/model.dart';

class ProfilePage extends StatelessWidget {
  Image profilePic;

 Future<void> setPic(WritersModel model)async{
    await model.db.retrievePicFromDataBase();
      List<dynamic> listOfDynamics = jsonDecode(model.db.profilePic.toString());
      List<int> listOfInts = listOfDynamics.map((e) => int.parse(e.toString()) )
          .toList();
      print(listOfInts);
      Uint8List typedPic = Uint8List.fromList(listOfInts);
      profilePic = Image.memory(typedPic);

  }

  @override
  Widget build(BuildContext context) {
    WritersModel model = Provider.of<WritersModel>(context);
    model.initializeName();


      //model.db.retrievePicFromDataBase().then((value) {model.image = File.fromRawPath(typedPic));};

    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: ListView(
          children: [
            FutureBuilder(
              future: setPic(model),
              builder: (context, snapshot) {

                if (profilePic != null) {
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
                            child: profilePic
                                ??Image.file(model.image)

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
              }
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
