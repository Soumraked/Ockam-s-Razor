import 'package:flutter/material.dart';
import 'package:ockams_razor/src/providers/death.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'dart:math';

import 'package:ockams_razor/src/utils/utils.dart';

class DeathPage extends StatefulWidget {
  @override
  _DeathPageState createState() => _DeathPageState();
}

class _DeathPageState extends State<DeathPage> {
  Muerte _muerte;
  Color _color;
  final _animationDuration = Duration(milliseconds: 800);

  @override
  void initState() {
    cargaMuertes.cargarData().then((value) {
      setState(() {
        _muerte = value;
      });
    });
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
                _textDeath(
                    ModalRoute.of(context).settings.arguments.toString()),
                _cardDeath(
                    ModalRoute.of(context).settings.arguments.toString()),
                Divider(),
                _buttonBack(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textDeath(String _message) {
    return Container(
      // color: Colors.blue,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: AutoSizeText(
            _messageMuerte(_message),
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

  Widget _cardDeath(String _message) {
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
          child: Image.asset(_imageMuerte(_message)),
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
            child: Text(
              'Volver a jugar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.07,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _messageMuerte(String message) {
    switch (message) {
      case 'menorSalud':
        return _muerte.menorSalud;
      case 'menorCarisma':
        return _muerte.menorCarisma;
      case 'menorDinero':
        return _muerte.menorDinero;
      case 'menorSuerte':
        return _muerte.menorSuerte;
      case 'mayorSalud':
        return _muerte.mayorSalud;
      case 'mayorCarisma':
        return _muerte.mayorCarisma;
      case 'mayorDinero':
        return _muerte.mayorDinero;
      case 'mayorSuerte':
        return _muerte.mayorSuerte;
      case 'random':
        return _muerte.random;
      default:
        return _muerte.random;
    }
  }

  String _imageMuerte(String message) {
    switch (message) {
      case 'menorSalud':
        return _muerte.imageSalud;
      case 'menorCarisma':
        return _muerte.imageCarisma;
      case 'menorDinero':
        return _muerte.imageDinero;
      case 'menorSuerte':
        return _muerte.imageSuerte;
      case 'mayorSalud':
        return _muerte.imageSalud;
      case 'mayorCarisma':
        return _muerte.imageCarisma;
      case 'mayorDinero':
        return _muerte.imageDinero;
      case 'mayorSuerte':
        return _muerte.imageSuerte;
      case 'random':
        return _muerte.imageRandom;
      default:
        return _muerte.imageRandom;
    }
  }

  void _redirectToMenu() {
    setPrefsString('section', 'parte1;1');
    setPrefsInt('_salud', 50);
    setPrefsInt('_carisma', 50);
    setPrefsInt('_dinero', 50);
    setPrefsInt('_suerte', 50);
    Navigator.pushNamed(context, 'menu');
  }
}
