import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slidingpuzzle/widgets/dialogFromAI.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speech extends StatefulWidget {
  Function clickGrid;
  Speech(this.clickGrid);

  @override
  _SpeechState createState() => _SpeechState();
}

/// An example that demonstrates the basic functionality of the
/// SpeechToText plugin for using the speech recognition capability
/// of the underlying platform.
class _SpeechState extends State<Speech> {
  bool _hasSpeech = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    var hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: true,
    );
    if (hasSpeech) {
      // Get the list of languages installed on the supporting platform so they
      // can be displayed in the UI for selection by the user.
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // HeaderWidget(),

      SpeechControlWidget(_hasSpeech, speech.isListening, startListening,
          stopListening, cancelListening),
      SessionOptionsWidget(_currentLocaleId, _switchLang, _localeNames,
          _logEvents, _switchLogging),

      // Expanded(
      //   child: RecognitionResultsWidget(lastWords: lastWords, level: level),
      // ),
      // Expanded(
      //   flex: 1,
      //   child: ErrorWidget(lastError: lastError),
      // ),
      // SpeechStatusWidget(speech: speech),
    ]);
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });

    print('Answer ${int.parse(result.recognizedWords).runtimeType} $result');
    if (result.finalResult) {
      print("Answer--finalresult-- ${result.recognizedWords}");
      widget.clickGrid(result.recognizedWords);
    } else {
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return dialogFromAI(0, "speech", () {});
      //     });
      print(result.recognizedWords);
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print("curren --> $selectedVal");
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  void _switchLogging(bool val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key key,
    @required this.lastWords,
    @required this.level,
  }) : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Center(
        //   child: Text(
        //     'Recognized Words',
        //     style: TextStyle(fontSize: 22.0),
        //   ),
        // ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).selectedRowColor,
                child: Center(
                  child: Text(
                    lastWords,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Positioned.fill(
              //   bottom: 10,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       width: 40,
              //       height: 40,
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //               blurRadius: .26,
              //               spreadRadius: level * 1.5,
              //               color: Colors.black.withOpacity(.05))
              //         ],
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(50)),
              //       ),
              //       child: IconButton(
              //         icon: Icon(Icons.mic),
              //         onPressed: () => null,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Speech recognition available',
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key key,
    @required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(this.hasSpeech, this.isListening,
      this.startListening, this.stopListening, this.cancelListening,
      {Key key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // TextButton(
        //   onPressed: !hasSpeech || isListening ? null : startListening,
        //   child: Text('Start'),
        // ),
        Text("Talk with AI   ",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
        !isListening
            ? GestureDetector(
                onTap: !hasSpeech || isListening ? null : startListening,
                child: Image.asset('assets/images/noaispeech.png',
                    fit: BoxFit.fill, width: 40, height: 40),
              )
            : GestureDetector(
                onTap: isListening ? stopListening : null,
                child: Image.asset('assets/images/aispeech.png',
                    fit: BoxFit.fill, width: 40, height: 40),
              ),
        // TextButton(
        //   onPressed: isListening ? stopListening : null,
        //   child: Text('Stop'),
        // ),
        // TextButton(
        //   onPressed: isListening ? cancelListening : null,
        //   child: Text('Cancel'),
        // )
      ],
    );
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(this.currentLocaleId, this.switchLang,
      this.localeNames, this.logEvents, this.switchLogging,
      {Key key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String) switchLang;
  final void Function(bool) switchLogging;
  final List<LocaleName> localeNames;
  final bool logEvents;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: DropdownButton<String>(
            dropdownColor: Color.fromARGB(174, 0, 221, 255),
            onChanged: (selectedVal) => switchLang(selectedVal),
            value: currentLocaleId,
            elevation: 16,
            icon: const Icon(Icons.arrow_drop_up_outlined),
            underline: Container(
              height: 2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 0, 255, 145),
                  Color.fromARGB(188, 0, 162, 255),
                ],
              )),
            ),
            items: localeNames
                .map(
                  (localeName) => DropdownMenuItem(
                    value: localeName.localeId,
                    child: Text(
                      localeName.name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class InitSpeechWidget extends StatelessWidget {
  const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key key})
      : super(key: key);

  final bool hasSpeech;
  final Future<void> Function() initSpeechState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: hasSpeech ? null : initSpeechState,
          child: const Text('Initialize'),
        ),
      ],
    );
  }
}

/// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key key,
    @required this.speech,
  }) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: speech.isListening
            ? Text(
                "I'm listening...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                'Not listening',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
