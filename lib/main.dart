import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black12),
            title: Text("Home", style: TextStyle(color: Colors.purple)),
            activeIcon: Icon(Icons.home, color: Colors.purple)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list, color: Colors.black12),
              title: Text("List", style: TextStyle(color: Colors.purple)),
              activeIcon: Icon(Icons.list, color: Colors.purple)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.black12),
              title: Text("Chat", style: TextStyle(color: Colors.purple)),
              activeIcon: Icon(Icons.chat, color: Colors.purple)
          )
        ],
      ),
      tabBuilder: (context, index) {
        return _childPages(index);
      },
    );
  }

  Widget _childPages(int index) {
    switch(index) {
      case 0: return CupertinoTabView(builder: (context) {
        return CupertinoPageScaffold(
          child: Home(),
        );
      });
      case 1: return CupertinoTabView(builder: (context) {
        return CupertinoPageScaffold(
          child: Word(),
        );
      });
      case 2: return CupertinoTabView(builder: (context) {
        return CupertinoPageScaffold(
          child: Chat(),
        );
      });
    }
  }
}

