import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'model/model.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        var pickerColor =
            Provider.of<WritersModel>(context, listen: false).pickerColor;
        var selectedColor =
            Provider.of<WritersModel>(context, listen: false).selectedColor;
        final changeColor =
            Provider.of<WritersModel>(context, listen: false).changeColor;
        showDialog(
          context: context,
          builder:(_)=> AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: changeColor,
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Got it'),
                onPressed: () {
                  selectedColor = pickerColor;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        Toast.show('Pick a color', context);
      },
      tooltip: 'choose color',
      child: Icon(
        FontAwesomeIcons.dashcube,
      ),
    );
  }
}
