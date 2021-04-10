import 'dart:async';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_event.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:articlemodel/articlemodel.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:writers_app/my_extensions.dart';




class SpeechWidget extends StatefulWidget {
  const SpeechWidget({Key key, }) : super(key: key);

  @override
  _SpeechWidgetState createState() => _SpeechWidgetState();
}

class _SpeechWidgetState extends State<SpeechWidget> {
  bool _hasSpeech = false;
  bool listening = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  Duration listenFor = Duration(seconds: 120);

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    //if (!mounted) return;

    _hasSpeech = hasSpeech;
  }

  Completer completer = Completer();

  doneListening() async {
    await Future.delayed(listenFor);
    //speech.statusListener();
  }

  @override
  Widget build(BuildContext context) {
    return (listening)
        ? CustomTap(
      onTap: (){
        listening = false;
        speech.stop();
      },
          child: Container(
              width: 50,
              height: 50,
              child: Loading(
                indicator: BallPulseIndicator(),
                color: Colors.orange,
              )),
        )
        : FloatingActionButton(
      heroTag: 'audio',
            backgroundColor: Colors.white70,
            child: JumpAnimation(child: Icon(FontAwesomeIcons.microphone)),
            onPressed: () {

              //setState(() {
                startListening();
             // });
            },
            // onTapUp: (details)=>speech.isListening ? stopListening : null,
          );
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
      onResult: resultListener,
      listenFor: listenFor,
      pauseFor: Duration(seconds: 5),
      partialResults: false,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: false,
      listenMode: ListenMode.confirmation,
    );
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ViewModel model = Provider.of<ViewModel>(context,listen: false);
    model.setFocus();
    ++resultListened;
    print('Result listener $resultListened');
    lastWords = '${result.recognizedWords}';
    Delta change = Delta()..push(Operation.insert('$lastWords\n'));;

    if(model.focus == 'title'){
      model.titleController.clearDocument();
    }

    model.controllerWithFocus.compose(change);
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {

      lastError = '${error.errorMsg} - ${error.permanent}';

  }

  void statusListener(String status) {
     setState(() {
    if (status == 'listening')
      listening = true;
    else
      listening = false;
     });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}




class CustomTap extends StatefulWidget {
  final Widget child;

  final GestureLongPressCallback onTap;

  const CustomTap({Key key, this.child, this.onTap}) : super(key: key);

  @override
  _CustomTapState createState() => _CustomTapState();
}

class _CustomTapState extends State<CustomTap> {

  @override
  Widget build(BuildContext context) {

    return RawGestureDetector(
      gestures: {

        AllowTap:GestureRecognizerFactoryWithHandlers<AllowTap>(
                ()=>AllowTap(),
                (instance)=>instance.onTap= widget.onTap
        )
      },
      child: widget.child,
    );
  }
}
class AllowTap extends TapGestureRecognizer{
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    super.acceptGesture(pointer);
  }
}

