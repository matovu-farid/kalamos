import 'package:flutter/cupertino.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class ViewModel with ChangeNotifier{

  ZefyrController titleController = ZefyrController(NotusDocument.fromDelta( Delta()..insert('\n')));
  ZefyrController bodyController = ZefyrController(NotusDocument.fromDelta( Delta()..insert('\n')));
  FocusNode titleFocusNode=FocusNode();
  FocusNode bodyFocusNode= FocusNode();

  NotusDocument loadDocument(String text) => NotusDocument.fromDelta( Delta()..insert('$text\n'));




}