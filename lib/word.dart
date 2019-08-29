import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Word extends StatefulWidget {

  @override
  State createState() => WordState();
}

class WordState extends State<Word> {

  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _style = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Sample Word'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.list),
                onPressed: _pushSaved
            ),
          ],
        ),
      body: _buildSuggestions()
    ) ;
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text (
        pair.asPascalCase,
        style: _style,
      ),
      trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext _context) {
              final Iterable<ListTile> tiles = _saved.map(
                      (WordPair pair) {
                    return ListTile(
                        title: Text(
                          pair.asPascalCase,
                          style: _style,
                        )
                    );
                  }
              );
              final List<Widget> divied = ListTile
                  .divideTiles(
                  context: context,
                  tiles: tiles
              )
                  .toList();

              return Scaffold(
                appBar: AppBar(
                  title: Text("Saved Suggestions"),
                ),
                body: ListView(children: divied),
              );
            }
        )
    );
  }
}