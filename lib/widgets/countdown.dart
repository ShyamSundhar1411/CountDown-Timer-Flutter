import 'dart:async';
import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import '../widgets/countdownDisplay.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

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

  Future<void> playAudio() async {
    await FlutterPlatformAlert.playAlertSound(iconStyle: IconStyle.exclamation,);

    final clickedButton = await FlutterPlatformAlert.showAlert(
      windowTitle: 'CountDown',
      text: 'CountDown has expired',
      alertStyle: AlertButtonStyle.ok,
      iconStyle: IconStyle.information,
    );
  }

  void cancelTimer() {
    timer?.cancel();
    isCountDown = false;
    playAudio();
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
                  ),
            SizedBox(width: 5),
            SizedBox(width: 5),
            Container(
              padding:EdgeInsets.all(8),
              decoration: BoxDecoration(),
              child:Center(child:Text("When you don't know what to do, you do what you know",style:TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.bold))))
          ]
        )
      )
    );
  }
}
