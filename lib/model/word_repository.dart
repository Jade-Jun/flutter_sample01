import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter_sample01/model/word_data.dart';

class WordRepository {

  static List<WordData> allData() {
    final List<WordPair> list = <WordPair>[];
    final List<WordData> items = <WordData>[];

    list.addAll(generateWordPairs().take(30));
    var rng = new Random();

    int idx = 0;
    list.forEach( (li) => {
      items.add(WordData(
        idx: idx,
        name: li.asPascalCase,
        price: rng.nextInt(500),
        imgName:'${rng.nextInt(30)}-0.jpg'
      )),
      idx++
    });
    return items;
  }
}