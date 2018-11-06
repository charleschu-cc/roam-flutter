import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  @override
  ListState createState() => new ListState();
}

class ListState extends State<ListWidget> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding:const EdgeInsets.all(16.0),
    children: snapshot.map((data) => _buildListCard(context, data)).toList(),
  );
}

Widget _buildListCard(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);

  return Card(
    child: new Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new ListTile(
          //leading: const Icon(Icons.album),
          title:
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child:
                new Text(record.name),
            ),
          //title: const Text('The Enchanted Nightingale'),
          subtitle:
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child:
                new Text(record.writeup),
            ),
          trailing: const Icon(Icons.fastfood),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListDetails(record)),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(
                  icon: Icon(Icons.bookmark_border, color: Colors.grey, size: 20.0),
                  onPressed: () => Firestore.instance.runTransaction((transaction) async {
                      final freshSnapshot = await transaction.get(record.reference);
                      final fresh = Record.fromSnapshot(freshSnapshot);

                      await transaction
                        .update(record.reference, {'votes': fresh.votes + 1});
                    }),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 0.0, right: 8.0, top: 8.0, bottom: 8.0),
                  child:
                    Text(record.votes.toString()),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  child:
                    const Icon(Icons.question_answer, color: Colors.grey, size: 20.0),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child:
                    Text(record.votes.toString()),
                ),
              ],
            ),
        ),
      ],
    ),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => Firestore.instance.runTransaction((transaction) async {
              final freshSnapshot = await transaction.get(record.reference);
              final fresh = Record.fromSnapshot(freshSnapshot);

              await transaction
                .update(record.reference, {'votes': fresh.votes + 1});
            }),
      ),
    ));
}

class Record {
  final String name;
  final String writeup;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        assert(map['writeup'] != null),
        name = map['name'],
        writeup = map['writeup'],
        votes = map['votes'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$writeup:$votes>";
}

class ListDetails extends StatelessWidget {
  final Record record;

  ListDetails(this.record);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.name),
      ),
      body: Center(

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
