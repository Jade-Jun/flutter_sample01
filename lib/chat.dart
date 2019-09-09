import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sample01/db/db_provider.dart';
import 'package:flutter_sample01/db/model/message.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Chat extends StatefulWidget {
  final String title;
  Chat({Key key, this.title}) : super(key: key);

  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<Chat> with TickerProviderStateMixin {

  final TextEditingController _textEditingController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final String _name = "jadejun";
  final String _resName = "mison";
  bool _isComposing = false;
  bool _loading = false;

  ChatScreenState()  {
    getData();
  }

  void getData() async {
    List<Message> list = await DBProvider.db.getMessage();

    list.forEach((f) => {
      _messages.insert(0,
          new ChatMessage(
            name: f.userName,
            message: f.msg,
            animationController: null,
            isResponse: f.userName == _name ? false : true,
            isAnimation: false,
          )
      )
    });
    setState(() {
      _loading = true;
    });
  }

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
      child: !_loading ?  Center(
        child: SpinKitWave(
          color: Colors.redAccent, type: SpinKitWaveType.center,
        ),
      ) : SafeArea(
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
      )
    );
  }

  @override
  void dispose() {

    if (_messages.isNotEmpty) {
      for (ChatMessage message in _messages) {
        if (message.animationController != null) {
          message.animationController.dispose();
        }
      }
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
      name: _name,
      message: text,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 700)
      ),
      isResponse: false,
      isAnimation: true,
    );

    ChatMessage chatResponse = new ChatMessage(
      message: text,
      name: _resName,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 700)
      ),
      isResponse: true,
      isAnimation: true,
    );

    setState(() {
      _messages.insert(0, chatMessage);
      _messages.insert(0, chatResponse);
    });

    DBProvider.db.insertMessage(Message(
      userName: _name,
      msg: text
    ));

    DBProvider.db.insertMessage(Message(
      userName: _resName,
      msg: text
    ));

    chatMessage.animationController.forward();
    chatResponse.animationController.forward();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.message, this.name, this.isAnimation, this.animationController, this.isResponse});

  final String message;
  final String name;
  final bool isResponse;
  final bool isAnimation;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    if(isAnimation) {
      return _aniBuilder(context);
    } else {
      return _noAniBuilder(context);
    }
  }

  Widget _aniBuilder(BuildContext context) {
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
                child: new CircleAvatar(
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(50),
                      child:  Image.asset(
                        isResponse ? "images/ic_apeach.png" : "images/ic_ryan.png",
                        width: 600,
                        height: 240,
                        fit: BoxFit.cover,),
                    )
                ),
              ),
              Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(name, style: Theme.of(context).textTheme.subhead,),
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

  Widget _noAniBuilder(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(50),
                  child:  Image.asset(
                    isResponse ? "images/ic_apeach.png" : "images/ic_ryan.png",
                    width: 600,
                    height: 240,
                    fit: BoxFit.cover,),
                )
            ),
          ),
          Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(name, style: Theme.of(context).textTheme.subhead,),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(message),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}