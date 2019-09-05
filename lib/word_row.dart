import 'package:flutter/material.dart';
import 'package:flutter_sample01/model/word_data.dart';
import 'package:flutter_sample01/styles.dart';
import 'package:flutter/cupertino.dart';

typedef void rowCallback(WordData data);

class WordRow extends StatefulWidget {

  final WordData wordData;
  final rowCallback favorChanged;

  const WordRow({
    @required this.wordData,
    @required this.favorChanged
  });

  @override
  State createState() => WordRowState(
    wordData: this.wordData,
  );
}

class WordRowState extends State<WordRow> {

  WordRowState({
    @required this.wordData
  });

  final WordData wordData;

  bool isFavor = false;

  @override
  Widget build(BuildContext context) {

    final row = GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  wordData.imgName,
                  package: 'shrine_images',
                  fit: BoxFit.cover,
                  width: 76,
                  height: 76,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        wordData.name,
                        style: Styles.rowItemName,
                      ),
                      Padding(padding: EdgeInsets.only(top: 8),),
                      Text(
                        '\$${wordData.price}',
                        style: Styles.rowItemPrice,
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavor ? CupertinoIcons.minus_circled : CupertinoIcons.plus_circled,
                  semanticLabel: 'Add',
                  color: CupertinoColors.activeBlue,
                ),
              )

            ],
          ),
        ),
      ),
      onTap: onChangedFavor,
    );

    return row;
  }

  void onChangedFavor() {
    setState(() {
      isFavor = !isFavor;
      widget.favorChanged(wordData);
    });
  }
}