import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dyi/tabNavigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 2;

  final items = <Widget>[
    const Icon(Icons.home, color: Colors.black, size: 30),
    const Icon(Icons.search, color: Colors.black, size: 30),
    const Icon(Icons.add, color: Colors.black, size: 30),
    const Icon(Icons.notifications, color: Colors.black, size: 30),
    const Icon(Icons.person, color: Colors.black, size: 30),
  ];

  String currentPage = "Page1";
  //int _selectedIndex = 0;
  int currentIndex = 0;
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == currentPage) {
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        // _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Persistant Button')),
        body: Stack(children: [
          _buildOffstageNavigator('Page1'),
          _buildOffstageNavigator('Page2'),
          _buildOffstageNavigator('Page3'),
          _buildOffstageNavigator('Page4'),
          _buildOffstageNavigator('Page5'),
        ]),
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: Colors.teal.shade100,
          backgroundColor: Colors.transparent,
          color: Colors.teal.shade500,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          height: 50,
          items: items,
          index: index,
          onTap: (index) => setState(() {
            _selectTab(pageKeys[index], index);

            this.index = index;
          }),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.red,
        //   onTap: (int index) {
        //     _selectTab(pageKeys[index], index);
        //   },
        //   currentIndex: _selectedIndex,
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Page 1'),
        //     BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Page 2'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.notification_add), label: 'Page 3'),
        //   ],
        //   type: BottomNavigationBarType.fixed,
        // ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
