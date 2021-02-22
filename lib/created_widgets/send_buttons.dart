import 'package:flutter/material.dart';
class SendButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SendButton({Key key, this.icon, this.label, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,style: TextStyle(color:Colors.white70),),
          Icon(icon,color: Colors.white70,),
        ],
      ),

      onPressed: onPressed,
    );
  }
}
