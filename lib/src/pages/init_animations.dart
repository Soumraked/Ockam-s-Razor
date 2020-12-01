import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ockams_razor/src/pages/menu.dart';

class InitAnimations extends StatefulWidget {
  @override
  _InitAnimationsState createState() => _InitAnimationsState();
}

class _InitAnimationsState extends State<InitAnimations> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // color: Colors.white,
          decoration: new BoxDecoration(
              color:Colors.black  
              // gradient: LinearGradient(
              //     colors: [Colors.yellow, Colors.orange, Colors.red],
              //     stops: [0.5, 0.5, 0.8],
              //     begin: FractionalOffset.topCenter,
              //     end: FractionalOffset.bottomCenter)
              ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('assets/loading2.gif'),
                  fit: BoxFit.cover,
                ),
                Divider(
                  height: 100,
                ),
                Text(
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey[800]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MenuPage()));
  }
}
