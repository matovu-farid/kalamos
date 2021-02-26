import 'package:flutter/material.dart';
import '../send_buttons.dart';
class ViewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SendButton(
      label: 'View Articles',
      icon: Icons.desktop_windows_outlined,
      onPressed: ()=>Navigator.of(context).pushNamed('/view'),
    );
  }
}
