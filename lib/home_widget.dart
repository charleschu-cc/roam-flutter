import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'placeholder_widget.dart';
import 'list_widget.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  int _currentNavIndex = 0;

  ListWidget list;
  ProfileWidget profile;
  List<Widget> _navChildren;

  // final List<Widget> _navChildren = [
  //   ListWidget(Colors.white),
  //   EditWidget(Colors.black),
  //   PlaceholderWidget(Colors.grey)
  // ];

  @override
  void initState() {
    list = ListWidget();
    profile = ProfileWidget(Colors.white);

    _navChildren = [
      _buildSuggestions(),
      list,
      profile
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Roam'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.search, semanticLabel: 'search'),
            onPressed: () {
              print('Search button');
            },
          ),
          new IconButton(icon: const Icon(Icons.tune), onPressed: _pushSaved),
        ],
      ),
      //body: _buildSuggestions(),
      body: _navChildren[_currentNavIndex],
      drawer: Drawer (
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text('Rachel Chu'),
              accountEmail: const Text('rachelchu@crazyrichasians.io'),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add account'),
              onTap: () {
                _addAccount(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Manage accounts'),
              onTap: () {
                _manageAccounts(context);
              },
            ),
            //AboutListTile(
            //  applicationVersion: "0.0.1",
            //),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentNavIndex,
        iconSize: 28.0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.bubble_chart),
            title: new Text('Add'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile')
          )
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        //if (i.isOdd) return Divider();

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  // Widget _buildRow(WordPair pair) {
  //   final bool alreadySaved = _saved.contains(pair);
  //   return ListTile(
  //     title: Text(
  //       pair.asPascalCase,
  //       style: _biggerFont,
  //     ),
  //     trailing: new Icon(
  //       alreadySaved ? Icons.favorite : Icons.favorite_border,
  //       color: alreadySaved ? Colors.red : null,
  //     ),
  //     onTap: () {
  //       setState(() {
  //         //alreadySaved = !alreadySaved;
  //         if (alreadySaved) {
  //           _saved.remove(pair);
  //         } else {
  //           _saved.add(pair);
  //         }
  //       });
  //     },
  //   );
  // }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
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
          const ListTile(
            leading: const Icon(Icons.album),
            title: const Text('The Enchanted Nightingale'),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
              .toList();

            return new Scaffold(
              appBar: new AppBar(
                title: const Text('Saved Suggestion'),
              ),
              body: new ListView(children: divided),
            );
        },
      ),
    );

  }

  void _addAccount(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Account not implemented.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _manageAccounts(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Account not implemented.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

}
