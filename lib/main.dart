import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample01/web_tab.dart';
import 'home.dart';
import 'chat.dart';
import 'word.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Sample2",
      home: Route()
    );
  }
}

class Route extends StatefulWidget {

  @override
  State createState() => RouteState();
}

class RouteState extends State<Route> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
            body: TabBarView(
              children: <Widget>[
                Home(),
                Word(),
                Chat(),
                WebTab(),
              ],
            ),
            bottomNavigationBar: Material(
                color: Colors.blue,
                child:  TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.home, color: Colors.white),
//            text: "Home"
                    ),
                    Tab(
                      icon: Icon(Icons.list, color: Colors.white),
//            text: "List",
                    ),
                    Tab(
                      icon: Icon(Icons.chat, color: Colors.white),
//            text: "chat",
                    ),
                    Tab(
                      icon: Icon(Icons.web, color: Colors.white),
                    ),
                  ],
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.red[100],
                )
            )
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
            title: new Text("App Info"),
            content: new Text("Do you want to exit an App?"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              new FlatButton(
                child: Text("Yes"),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
        ) ?? false
    );
  }
}

