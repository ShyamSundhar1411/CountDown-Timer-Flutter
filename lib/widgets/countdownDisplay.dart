import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stopwatch_app/widgets/timeCard.dart';

class CountDownDisplayWidget extends StatelessWidget {
  final Duration duration;
  CountDownDisplayWidget(this.duration);
  String convertoTwoDigits(int n) {
    return n.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final seconds = convertoTwoDigits(duration.inSeconds.remainder(60));
    final minutes = convertoTwoDigits(duration.inMinutes.remainder(60));
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TimeCardWidget(
              "Hours", convertoTwoDigits(duration.inHours.remainder(60))),
          SizedBox(width: 8),
          TimeCardWidget("Minutes", minutes.toString()),
          SizedBox(width: 8),
          TimeCardWidget("Seconds", seconds.toString()),
        ],
      ),
    );
    ;
  }
}
