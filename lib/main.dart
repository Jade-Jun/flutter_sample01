import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample01/web_tab.dart';
import 'home.dart';
import 'chat.dart';
import 'word.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Sample2",
      home: DefaultTabController(
        length: 4,
        child: Route(),
      )
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
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          Home(),
          Word(),
          Chat(),
          WebTab()
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
            )
          ],
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.red[100],
        )
      )
    );
  }
}

