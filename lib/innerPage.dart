import 'package:dyi/veryInnerPage.dart';
import 'package:flutter/material.dart';

class InnerPage extends StatelessWidget {
  const InnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const VeryInnerPage()));
              },
              child: const Text(' Inner page'))),
    ));
  }
}
