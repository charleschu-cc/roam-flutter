import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SuggestionWidget extends StatefulWidget {
  final Set<WordPair> saved;

  SuggestionWidget(this.saved);

  @override
  SuggestionState createState() => new SuggestionState();
}

class SuggestionState extends State<SuggestionWidget> {
  final _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildCard(_suggestions[index]);
      }
    );
  }

  Widget _buildCard(WordPair pair) {
    final bool alreadySaved = widget.saved.contains(pair);
    //print(pair.asPascalCase);
    return Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'images/lake.jpg',
            width: 600.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
          new ListTile(
            leading: const Icon(Icons.album),
            title: new Text(pair.asPascalCase),
            //title: const Text('The Enchanted Nightingale'),
            subtitle: const Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          new ButtonTheme.bar(
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('Buy Tickets'),
                  onPressed: () {   },
                ),
                new FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () {  },
                ),
                new IconButton(
                  icon: (alreadySaved
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border)),
                  color: alreadySaved ? Colors.red : null,
                  onPressed: () {
                    setState(() {
                      if (alreadySaved) {
                        widget.saved.remove(pair);
                      } else {
                        widget.saved.add(pair);
                      }
                    });
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
