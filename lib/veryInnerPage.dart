import 'package:flutter/material.dart';

class VeryInnerPage extends StatelessWidget {
  const VeryInnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(child: Text('Very Inner Page')),
    ));
  }
}
