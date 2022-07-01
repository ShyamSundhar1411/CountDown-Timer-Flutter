import 'dart:async';
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import '../widgets/countdownDisplay.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  Duration duration = Duration(seconds: 0);
  Timer? timer;
  bool isCountDown = false;
  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        isCountDown = true;
        final seconds = duration.inSeconds - 1;
        if (seconds >= 0) {
          duration = Duration(seconds: seconds);
        } else {
          cancelTimer();
        }
      });
    });
  }

  void cancelTimer() {
    timer?.cancel();
    isCountDown = false;
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 3, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );
    print("Played");
  }

  void determineStoporPlay(Duration duration) {
    if (duration.inSeconds != 0 ||
        duration.inHours != 0 ||
        duration.inMinutes != 0) {
      setState(() {
        isCountDown = false;
         timer?.cancel();
      });
    } else {
      cancelTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                  height: 300,
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    initialTimerDuration: duration,
                    onTimerDurationChanged: (value) {
                      setState(() {
                        duration = value;
                      });
                    },
                  )));
        },
        child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CountDownDisplayWidget(duration),
                  SizedBox(width: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: isCountDown ? null : startTimer,
                          child: Text("Start Count Down")),
                      SizedBox(width: 5),
                      ElevatedButton(
                          onPressed: isCountDown
                              ? () {
                                  determineStoporPlay(duration);
                                }
                              : null,
                          child: Text("Stop Count Down")),
                    ],
                  )
                ])));
  }
}
