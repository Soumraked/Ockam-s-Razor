import 'package:flutter/material.dart';
import 'package:ockams_razor/src/pages/game.dart';
import 'package:ockams_razor/src/pages/info_game.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'dart:async';
import 'dart:math';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  final _animationDuration = Duration(milliseconds: 800 );
  Timer _timer;
  Color _color;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_animationDuration, (timer) => _changeColor());
    _color = Colors.blue;
  }

  void _changeColor() {
    List<dynamic> colores=[
      Colors.red,
      Colors.blue,
      Colors.blueAccent,
      Colors.pink,
      Colors.green,
    ];

    int largoLista= colores.length;
    Random random = new Random();
    int randomNumber = random.nextInt(largoLista);
    _color = colores[randomNumber];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        //  color:Colors.black,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage("assets/main2.gif"),
              fit: BoxFit.fill, 
              
            ) ,
          
          ),
          child: Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.start ,
              mainAxisSize: MainAxisSize.min,
              children: [Divider(),
                        TyperAnimatedTextKit(
                      
                    speed: Duration(milliseconds: 125),
                    pause: Duration(milliseconds:  1),
                    isRepeatingAnimation:false ,
                    text: [ "Ockam's Razor"],
                    textStyle:
                    TextStyle(
                      fontSize: 40.0, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mia',
                      color: Colors.lightBlue,
                      height:4,    
                      shadows:<Shadow>[
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 30.0,
                          color: Color.fromARGB(70, 255, 0, 0),
                        ),   
                      ],
                     ),
                ),
                Divider(),
                AnimatedContainer(
                   duration: _animationDuration,
                  color: _color,
                  padding: EdgeInsets.all(2),
                  child: FlatButton(
                    // color: Colors.black,
                    splashColor: _color,
                    onPressed: () {
                      _playGame();
                    },
                    child: Text(
                      "Jugar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Divider(),
                AnimatedContainer(
                  duration:_animationDuration,
                  color: _color,
                  padding: EdgeInsets.all(2),
                  child: FlatButton(
                    // color: Colors.black,
                    splashColor: Colors.blue,
                    onPressed: () {
                      _infoGame();
                    },
                    child: Text(
                      "Como jugar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black,
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
