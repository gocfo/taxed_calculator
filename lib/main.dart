import 'package:flutter/material.dart';
import 'pub.dart';
import 'count.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData.light(),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _homeBottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list..add(CountPage())..add(PubPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 30.0),
        child: list[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pages,
              color: _homeBottomNavigationColor,
            ),
            title: Text(
              "计税",
              style: TextStyle(color: _homeBottomNavigationColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: _homeBottomNavigationColor,
            ),
            title: Text(
              "开票",
              style: TextStyle(color: _homeBottomNavigationColor),
            ),
          ),
        ],
      ),
    );
  }
}
