import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'list_widget.dart';
import 'suggestion_widget.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  int _currentNavIndex = 0;

  SuggestionWidget suggest;
  ListWidget list;
  ProfileWidget profile;
  List<Widget> _navChildren;


  @override
  void initState() {
    list = ListWidget();
    profile = ProfileWidget(Colors.white);
    suggest = SuggestionWidget(_saved);

    _navChildren = [
      suggest,
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
