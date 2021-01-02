import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'dart:math';

import 'package:ockams_razor/src/utils/utils.dart';

class WinPage extends StatefulWidget {
  @override
  _WinPageState createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {
  Color _color;
  final _animationDuration = Duration(milliseconds: 800);

  @override
  void initState() {
    Timer.periodic(_animationDuration, (timer) => _changeColor());
    _color = Colors.blue;
    super.initState();
  }

  void _changeColor() {
    List<dynamic> colores = [
      Colors.red,
      Colors.blue,
      Colors.blueAccent,
      Colors.pink,
      Colors.green,
    ];
    int largoLista = colores.length;
    Random random = new Random();
    int randomNumber = random.nextInt(largoLista);
    _color = colores[randomNumber];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(12, 12, 12, 1),
          // appBar: AppBar(),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textWin(),
                _cardWin(),
                Divider(),
                _buttonBack(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textWin() {
    return Container(
      // color: Colors.blue,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: AutoSizeText(
            "Felicidades, haz llegado al fin de Ockam's Razor por el momento, mantente atento a nuevas actualizaciones para poder seguir tu hstoria con Seymour Diera.\nMuchas gracias por jugar, nos vemos en el futuro.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _cardWin() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(2, 10))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          child: Image.asset('assets/fondo.jpg'),
        ),
      ),
    );
  }

  Widget _buttonBack() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(12, 12, 12, 1),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: _animationDuration,
          color: _color,
          padding: EdgeInsets.all(2),
          child: FlatButton(
              splashColor: _color,
              onPressed: () {
                _redirectToMenu();
              },
              child: Container(
                // color: Colors.blue,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Center(
                    child: AutoSizeText(
                      "Volver a la pantalla principal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void _redirectToMenu() {
    setPrefsBool('partida', false);
    setPrefsString('section', 'parte1;1');
    setPrefsInt('_salud', 50);
    setPrefsInt('_carisma', 50);
    setPrefsInt('_dinero', 50);
    setPrefsInt('_suerte', 50);
    Navigator.pushNamed(context, '/');
  }
}
