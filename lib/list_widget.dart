import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  //final Color color;

  //ListWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.red,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class EditWidget extends StatelessWidget {
  final Color color;

  EditWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: Colors.green,
    );
  }
}
