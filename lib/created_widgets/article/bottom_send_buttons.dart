import 'package:animations/animations.dart';
import 'package:articlemodel/articlemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSendButtons extends StatefulWidget {
  const BottomSendButtons({
    Key key
  }) : super(key: key);

  @override
  _BottomSendButtonsState createState() => _BottomSendButtonsState();
}

class _BottomSendButtonsState extends State<BottomSendButtons> {

  @override
  Widget build(BuildContext context) {
    var bloc  = Provider.of<WritersModel>(context,listen: false).viewBloc;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

          UploadButton(bloc:bloc),
        DeleteButton(bloc:bloc),
      ],
    );
  }
}

class UploadButton extends StatefulWidget {
  final ViewBloc bloc;
  const UploadButton({
    Key key,
    this.bloc
  }) : super(key: key);

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> with SingleTickerProviderStateMixin{
  AnimationController _animationController;

  @override
  void initState() {

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();
    super.initState();

  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return PopAnimation(
      animationController: _animationController,
      child: ViewButton(
        text: 'Upload',
        onPressed:(){
          _animationController.reset();
          _animationController.forward();

          widget.bloc.upLoadMultipleArticles(context,'writers');


        }),
    );
  }
}

class DeleteButton extends StatefulWidget {
  const DeleteButton({
    Key key,
     this.index, this.bloc
  }) : super(key: key);

  final int index;
  final ViewBloc bloc;

  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<WritersModel>(context, listen: false);
    var index = DefaultTabController.of(context).index;
    return PopAnimation(
      animationController: _controller,
      child: ViewButton(
          text: 'Delete',
          onPressed: (){
            if(index ==1)
            widget.bloc.deleteFromCache();
            else model.cloudBloc.deleteMultipleFromCloud();
            _controller.reset();
            _controller.forward();
            //_controller.reverse();
          }
      ),
    );
  }
}

class ViewButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ViewButton({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: 'View$text', onPressed: onPressed, label: Text(text));
  }
}