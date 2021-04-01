
import 'package:zefyr/zefyr.dart';

extension MoreZefyr on ZefyrController{
  void clearDocument() {
    this.replaceText(0, this.document.length - 1, '');
  }
}