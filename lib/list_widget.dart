import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  @override
  ListState createState() => new ListState();
}

class ListState extends State<ListWidget> {
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

class ListWidget0 extends StatelessWidget {
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

class ProfileWidget extends StatelessWidget {
  final Color color;

  ProfileWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: color,
    );
  }
}
