import 'package:articleclasses/articleclasses.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';
import 'package:provider/provider.dart';
import 'package:articlemodel/articlemodel.dart';
import 'package:flutter/material.dart';

class MyAppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
  final WritersModel model;
  // final OriginalArticle article;

  MyAppZefyrImageDelegate(this.model);

  @override
  Future<String> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    return await model.saveArticlePic(pickedFile);
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    return Image(image: NetworkImage(key));
  }

  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;
}