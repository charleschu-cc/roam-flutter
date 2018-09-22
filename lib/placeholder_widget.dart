import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
 final Color color;

 PlaceholderWidget(this.color);

 @override
 Widget build(BuildContext context) {
   return ListView.builder(
     itemExtent: 250.0,
     itemBuilder: (context, index) => Container(
       padding: EdgeInsets.all(10.0),
       child: Material(
         elevation: 4.0,
         borderRadius: BorderRadius.circular(5.0),
         color: this.color,
         child: Center(
           child: Text(index.toString()),
         ),
       ),
     ),
   );
 }
}
