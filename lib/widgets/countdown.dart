import 'dart:async';
import "package:flutter/material.dart";
import '../widgets/countdownDisplay.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  Duration duration = Duration(seconds: 3);
  Timer? timer;
  bool isCountDown = true;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        final seconds = duration.inSeconds - 1;
        if (seconds > 0) {
          duration = Duration(seconds: seconds);
        } else {
          timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CountDownDisplayWidget(duration);
  }
}
