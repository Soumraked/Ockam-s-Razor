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
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MenuPage()));
        },
      ),
    );
  }

  List<Widget> _images() {
    List<Widget> _aux = new List();

    _aux.add(_image1());
    _aux.add(_image2());
    _aux.add(_image3());

    return _aux;
  }

  Widget _image1() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.8, 1],
          colors: [
            Color(0xFF4563DB),
            Color(0xFF5B16D0),
            Color(0xFF5036D5),
            Color(0xFF3594DD),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
                'https://static.wikia.nocookie.net/leagueoflegends/images/1/10/Towa_profileicon.png/revision/latest/top-crop/width/220/height/220?cb=20190827203050'),
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

  Widget _image2() {
    return Container(
      color: Colors.cyanAccent[100],
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(
                'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Neeko_0.jpg'),
            placeholder: AssetImage('assets/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Foods Item",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey[800]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Container(
              width: 90,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/500/300/?image=2'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "Pizza",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            subtitle: Text(
              "Pizza is the world’s greatest food. Nothing says “I love you,” “I’m sorry,” or “Let’s be friends,” better than pizza.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Container(
              width: 90,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/500/300/?image=2'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "Pasta",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            subtitle: Text(
              "A super quick, healthy and delicious pasta that can de whipped up under\n15 minutes.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Container(
              width: 90,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/500/300/?image=2'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "Chilli Potato",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            subtitle: Text(
              "Chilli potato is a Indo chinese starter made with fried potatoes tossed in spicy, slightly sweet & sour chilli sauce. ",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
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
