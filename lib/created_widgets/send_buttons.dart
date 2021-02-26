import 'package:flutter/material.dart';
class SendButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SendButton({Key key, this.icon, this.label, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(

      child:Icon(icon,color: Colors.white,),

      onPressed: onPressed,
    );
  }
}
