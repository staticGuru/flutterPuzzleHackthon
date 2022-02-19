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

  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    var hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
      debugLogging: true,
    );
    if (hasSpeech) {
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
      SpeechControlWidget(_hasSpeech, speech.isListening, startListening,
          stopListening, cancelListening),
      SessionOptionsWidget(_currentLocaleId, _switchLang, _localeNames,
          _logEvents, _switchLogging),
    ]);
  }

  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 2),
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

  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');

    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
    var conversion = int.tryParse(result.recognizedWords);

    if (conversion != null && result.recognizedWords != null) {
      if (result.finalResult) {
        widget.clickGrid(result.recognizedWords);
      }
    } else {
      if (result.finalResult) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialogFromAI(0, result.recognizedWords, () {});
            });
      }

      print(result.recognizedWords);
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);

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

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialogFromAI(0, error.errorMsg, () {});
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
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
    }
  }

  void _switchLogging(bool val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }
}

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
