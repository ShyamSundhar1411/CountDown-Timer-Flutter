import 'package:flutter/material.dart';

class TimeCardWidget extends StatelessWidget {
  final String toDisplay;
  final String Component;
  TimeCardWidget(this.toDisplay,this.Component);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Text(Component,style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 72))
      ),
      Container(padding:EdgeInsets.all(8),child:Text(toDisplay,style:TextStyle(color:Colors.white,)))
    ]);
  }
}
