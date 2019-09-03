import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class Chat extends StatefulWidget {
  final String title;
  Chat({Key key, this.title}) : super(key: key);

  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<Chat> with TickerProviderStateMixin {

  final TextEditingController _textEditingController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sample Chat'),
      ),
    body: DecoratedBox(
      decoration: const BoxDecoration(
          color: Color(0xfff0f0f0)
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
                )
            ),
            Divider(height: 1),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor
              ),
              child: _buildTextComposer()
            )
          ],
        ),
      ),
    ),
//      body: Container(
//          child: Column(
//            children: <Widget>[
//              new Flexible(
//                  child: ListView.builder(
//                    padding: new EdgeInsets.all(8.0),
//                    reverse: false,
//                    itemBuilder: (_, int index) => _messages[index],
//                    itemCount: _messages.length,
//                  )
//              ),
//              new Divider(height: 1.0),
//              new Container(
//                decoration: new BoxDecoration(
//                    color: Theme.of(context).cardColor
//                ),
//                child: _buildTextComposer(),
//              )
//            ],
//          ),
//          decoration: Theme.of(context).platform == TargetPlatform.iOS
//              ? new BoxDecoration(
//              border: new Border(
//                  top: new BorderSide(color: Colors.grey[200])
//              )
//          )
//              : null
//      )
    );
  }


  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  Widget _buildTextComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Flexible(child: TextField(
                  controller: _textEditingController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration.collapsed(hintText: "input the text"),
                ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? CupertinoButton(
                        child: Text("Send"),
                        onPressed: _isComposing
                            ? () => _handleSubmitted(_textEditingController.text)
                            : null
                    )
                        : IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => _isComposing
                            ? _handleSubmitted(_textEditingController.text)
                            : null
                    )
                )
              ],
            )
        )
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage chatMessage = new ChatMessage(
      message: text,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 700)
      ),
    );
    setState(() {
      _messages.insert(0, chatMessage);
    });
    chatMessage.animationController.forward();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.message, this.animationController});

  final String message;
  final String _name = "jadejun";
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOut
        ),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(_name[0])),
              ),
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(_name, style: Theme.of(context).textTheme.subhead,),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(message),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
