import 'package:flutter/cupertino.dart';
import 'package:writers_app/created_widgets/uploaded_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_widgets/article/view_articles.dart';
import 'package:writers_app/created_widgets/sending_buttons/save_Article.dart';
import 'package:writers_app/model/model.dart';
import 'sending_buttons/share.dart';
import './sending_buttons/view_button.dart';
import 'package:writers_app/created_widgets/article/bottom_send_buttons.dart';

class Uploaded extends StatelessWidget {
  final color = Colors.blueGrey;
  final textColor = Colors.white70;

  Uploaded({Key key}) : super(key: key);
  List<Widget> listOfTiles;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UploadedList(),
        Align(
          alignment: Alignment.bottomRight,
            child: DeleteButton(type: 'cloud',))
      ],
    );
  }
}
