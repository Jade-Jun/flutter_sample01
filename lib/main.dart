import 'package:flutter/material.dart';
import 'home.dart';
import 'chat.dart';
import 'word.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Sample2",
      home: Route(),
    );
  }
}

class Route extends StatefulWidget {

  @override
  State createState() => RouteState();
}

class RouteState extends State<Route> {

  int _currentIdx = 0;
  final List<Widget> _children = [
    Home(),
    Word(),
    Chat()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdx,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: Colors.black12),
            title: new Text("Home", style: TextStyle(color: Colors.purple)),
            activeIcon: new Icon(Icons.home, color: Colors.purple),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list, color: Colors.black12),
            title: new Text("List", style: TextStyle(color: Colors.purple)),
            activeIcon: new Icon(Icons.list, color: Colors.purple)
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.chat, color: Colors.black12),
            title: new Text("Chat", style: TextStyle(color: Colors.purple)),
            activeIcon: new Icon(Icons.chat, color: Colors.purple)
          )
        ],
        onTap: onTabTapped,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIdx = index;
    });
  }
}

