import 'package:dyi/tabNavigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String currentPage = "Page1";
  int _selectedIndex = 0;
  int currentIndex = 0;
  List<String> pageKeys = ["Page1", "Page2", "Page3"];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == currentPage) {
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        _selectedIndex = index;
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
        body: Stack(children: [
          _buildOffstageNavigator('Page1'),
          _buildOffstageNavigator('Page2'),
          _buildOffstageNavigator('Page3'),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Page 1'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Page 2'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_add), label: 'Page 3'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
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
