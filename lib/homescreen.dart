import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Fragrement1.dart';
import 'fragment2.dart';
import 'fragment3.dart';
import 'fragment4.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;



  PageController _pageController = PageController();
  List<Widget> _widgetOptions = [
  Fragment1(),
  Fragment2(),
  Fragment3(),
  Fragment4(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Compan",
            style: TextStyle(
              // fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body:
           PageView(
            controller: _pageController,
            children: _widgetOptions,
            physics: NeverScrollableScrollPhysics(),
          ),

        floatingActionButton: FloatingActionButton(
          child: Text("hi"),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          // showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }
          ),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              // activeColor: HexColor("#F0C3F8"),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.table_chart_outlined),
              title: Text('Users'),
              // activeColor: HexColor("#F0C3F8"),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.event_note_rounded),
              title: Text('Messages'),
              // activeColor: HexColor("#F0C3F8"),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Settings'),
              // activeColor: HexColor("#F0C3F8"),
            ),
          ],
        ));
  }
}
