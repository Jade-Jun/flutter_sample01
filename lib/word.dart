import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_sample01/model/word_data.dart';
import 'package:flutter_sample01/model/word_repository.dart';
import 'package:flutter_sample01/word_row.dart';

class Word extends StatefulWidget {

  @override
  State createState() => WordState();
}

class WordState extends State<Word> {

  final List<WordData> _suggestions = WordRepository.allData();
  final Set<WordData> _saved = Set<WordData>();
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

  void rowCallback(WordData data) {
    final bool alreadySaved = _saved.contains(data);

    if (alreadySaved) {
      _saved.remove(data);
    } else {
      _saved.add(data);
    }
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          var row = WordRow(
              wordData: _suggestions[i],
              favorChanged: rowCallback,
          );
          return row;
        },
      itemCount: _suggestions.length,
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext _context) {
              final Iterable<ListTile> tiles = _saved.map(
                      (WordData pair) {
                    return ListTile(
                        title: Text(
                          pair.name,
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