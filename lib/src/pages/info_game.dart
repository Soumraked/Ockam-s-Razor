import 'package:flutter/material.dart';

import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'package:ockams_razor/src/pages/menu.dart';

class InfoGame extends StatefulWidget {
  @override
  _InfoGameState createState() => _InfoGameState();
}

class _InfoGameState extends State<InfoGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LiquidSwipe(
          pages: _images(),
          enableLoop: false,
          fullTransitionValue: 300,
          enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.5,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.arrow_back),
        backgroundColor: Color.fromARGB(221, 160, 54, 20),
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
      ),
    );
  }

  List<Widget> _images() {
    List<Widget> _aux = new List();
    _aux.add(_image1());
    _aux.add(_image3());
    return _aux;
  }

  Widget _image1() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(12, 12, 12, 1),
        image: DecorationImage(
          image: AssetImage("assets/7dDt.gif"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 90,
            backgroundImage: AssetImage("assets/icono2.jpg"),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Ockam's Razor",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          Text(
            "A new tale",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey),
          ),
          Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.white,
              child: Container()),
        ],
      ),
    );
  }

  Widget _image3() {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text(
            "Para jugar en la próxima pantalla, presiona\n sobre la tarjeta y delizala a la \nderecha/izquiera para seleccionar la \nalternativa que te paresca correcta.",
            style: TextStyle(fontSize: 16.0, color: Colors.white),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset("assets/card_animation.gif"),
          SizedBox(
            height: 30,
          ),
          Text(
            'Order Success',
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Now, you're connect directly\nwith your order, lets check the detail\nJust wait your service here",
            style: TextStyle(fontSize: 16.0, color: Colors.white),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
