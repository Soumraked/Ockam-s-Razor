import 'package:flutter/material.dart';

import 'package:ockams_razor/src/pages/game.dart';
import 'package:ockams_razor/src/pages/info_game.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
                Text(
                  "Ockam's Razor",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.lightBlue),
                ),
                Divider(),
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(2),
                  child: FlatButton(
                    color: Colors.black,
                    splashColor: Colors.red,
                    onPressed: () {
                      _playGame();
                    },
                    child: Text(
                      "Jugar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(2),
                  child: FlatButton(
                    color: Colors.black,
                    splashColor: Colors.red,
                    onPressed: () {
                      _infoGame();
                    },
                    child: Text(
                      "Como jugar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _playGame() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Game()));
  }

  void _infoGame() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => InfoGame()));
  }
}
