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
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('assets/loading.gif'),
                  fit: BoxFit.cover,
                ),
                Text(
                  'Cargando...',
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
