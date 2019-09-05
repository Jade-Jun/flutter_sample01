import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {

  static const TextStyle rowItemName = TextStyle(
      color: Color.fromRGBO(0, 0, 0, 0.8),
      fontSize: 18,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal
  );

  static const TextStyle rowTotal = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold
  );

  static const TextStyle rowItemPrice = TextStyle(
    color: Color(0xFF8E8E93),
    fontSize: 13,
    fontWeight: FontWeight.w300,
  );
}