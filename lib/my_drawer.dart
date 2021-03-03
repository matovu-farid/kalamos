import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      AppBar(),
      DrawerButton(text: 'Profile',
          onPressed: ()=>Navigator.of(context).pushNamed('/Profile')
          ),
      DrawerButton(
        text: 'Sign Out',
        onPressed: () =>
            Provider.of<WritersModel>(context, listen: false).signout(),
      )
    ]));
  }
}

class DrawerButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DrawerButton({Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(builder: (context, constraints) {
        return FlatButton(
          key: Key('$text'),
          minWidth: constraints.maxWidth,
          shape: RoundedRectangleBorder(),
          child: Text(
            text,
          ),
          onPressed: onPressed,
        );
      }),
    );
  }
}
