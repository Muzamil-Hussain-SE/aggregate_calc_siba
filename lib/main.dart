import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  int _count = 10;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: _count,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              height: 75,
              width: 120,
              child: Text('Pe'),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
