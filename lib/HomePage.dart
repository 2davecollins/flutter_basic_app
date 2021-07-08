import 'package:flutter/material.dart';
import 'LocalmapPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Container(
          height: 80,
          width: 450,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LocalmapPage()));
            },
            child: Text(
              'Back to Hell no return',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}