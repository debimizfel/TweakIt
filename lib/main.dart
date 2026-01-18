import 'package:flutter/material.dart';
import 'package:myapp/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TweakIt',
      home: Scaffold(
        appBar: AppBar(title: Text('TweakIt')),
        body: Padding(padding: const EdgeInsets.all(15), child: HomePage()),
      ),
    );
  }
}
