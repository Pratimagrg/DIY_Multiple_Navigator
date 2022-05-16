import 'package:dyi/page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'page2.dart';
import 'page3.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (tabItem == "Page1")
      child = Page1();
    else if (tabItem == "Page2")
      child = Page2();
    else if (tabItem == "Page3") child = Page3();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
