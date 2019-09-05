import 'package:flutter/cupertino.dart';

class WordData {

  const WordData({
    @required this.idx,
    @required this.name,
    @required this.imgName,
    @required this.price
  });

  final int idx;
  final String name;
  final String imgName;
  final int price;
}