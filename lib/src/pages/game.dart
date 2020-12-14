import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ockams_razor/src/pages/menu.dart';

import 'package:ockams_razor/src/utils/utils.dart';

import 'package:ockams_razor/src/providers/dialogs.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:auto_size_text/auto_size_text.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  // List<String> _images = new List();
  // int _uiltimoItem = 0;
  // int _cardNum = 3;
  CardController _controllerCard = new CardController();
  String _direction = 'None';
  int _currentCard = 0;
  double _salud = 50;
  double _reputacion = 50;
  double _dinero = 50;
  double _santidad = 50;
  bool _saludStatus = false;
  bool _reputacionStatus = false;
  bool _dineroStatus = false;
  bool _santidadStatus = false;
  String _saludSigno = "";
  String _reputacionSigno = "";
  String _dineroSigno = "";
  String _santidadSigno = "";
  List<Dialogo> _dialogos = new List();

  @override
  void initState() {
    super.initState();

    // getPrefsInt('CurrentCard').then((value) {
    //   _currentCard = value;
    //   _appendImages10();
    // });

    cargaDialogos.cargarData().then((value) {
      setState(() {
        _dialogos = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    setPrefsInt('CurrentCard', _currentCard);
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
                _status(),
                _question(),
                _tinderSwipe(),
                _answer(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _backButton(),
    );
  }

  Widget _tinderSwipe() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: new TinderSwapCard(
        swipeUp: true,
        swipeDown: true,
        orientation: AmassOrientation.BOTTOM,
        totalNum: _dialogos.length,
        stackNum: 3,
        swipeEdge: 6.0,
        animDuration: 300,
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        maxHeight: MediaQuery.of(context).size.width * 0.9,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        minHeight: MediaQuery.of(context).size.width * 0.8,
        cardBuilder: (context, index) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(_dialogos[index].imagen),
              ),
            ),
          ),
        ),
        cardController: _controllerCard,
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            //Card is LEFT swiping
            _direction = 'Left';
            if (_dialogos[0].izquierdaSalud != 0.0) {
              _saludStatus = true;
            }
            if (_dialogos[0].izquierdaReputacion != 0.0) {
              _reputacionStatus = true;
            }
            if (_dialogos[0].izquierdaDinero != 0.0) {
              _dineroStatus = true;
            }
            if (_dialogos[0].izquierdaSantidad != 0.0) {
              _santidadStatus = true;
            }
          } else if (align.x > 0) {
            //Card is RIGHT swiping
            _direction = 'Rigth';
            if (_dialogos[0].derechaSalud != 0.0) {
              _saludStatus = true;
            }
            if (_dialogos[0].derechaReputacion != 0.0) {
              _reputacionStatus = true;
            }
            if (_dialogos[0].derechaDinero != 0.0) {
              _dineroStatus = true;
            }
            if (_dialogos[0].derechaSantidad != 0.0) {
              _santidadStatus = true;
            }
          } else {
            _direction = 'None';

            _saludStatus = false;
            _reputacionStatus = false;
            _dineroStatus = false;
            _santidadStatus = false;
          }
          _saludSigno = '';
          _reputacionSigno = '';
          _dineroSigno = '';
          _santidadSigno = '';
          setState(() {});
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          /// Get orientation & index of swiped card!
          _direction = 'None';
          _saludStatus = false;
          _reputacionStatus = false;
          _dineroStatus = false;
          _santidadStatus = false;

          print(_saludStatus);
          print(_reputacionStatus);
          print(_dineroStatus);
          print(_santidadStatus);

          if (orientation == CardSwipeOrientation.LEFT) {
            _salud += _dialogos[0].izquierdaSalud;
            _reputacion += _dialogos[0].izquierdaReputacion;
            _dinero += _dialogos[0].izquierdaDinero;
            _santidad += _dialogos[0].izquierdaSantidad;

            _saludSigno = _dialogos[0].izquierdaSalud > 0
                ? '+'
                : _dialogos[0].izquierdaSalud < 0
                    ? '-'
                    : '';
            _reputacionSigno = _dialogos[0].izquierdaReputacion > 0
                ? '+'
                : _dialogos[0].izquierdaReputacion < 0
                    ? '-'
                    : '';
            _dineroSigno = _dialogos[0].izquierdaDinero > 0
                ? '+'
                : _dialogos[0].izquierdaDinero < 0
                    ? '-'
                    : '';
            _santidadSigno = _dialogos[0].izquierdaSantidad > 0
                ? '+'
                : _dialogos[0].izquierdaSantidad < 0
                    ? '-'
                    : '';
          }

          if (orientation == CardSwipeOrientation.RIGHT) {
            _salud += _dialogos[0].derechaSalud;
            _reputacion += _dialogos[0].derechaReputacion;
            _dinero += _dialogos[0].derechaDinero;
            _santidad += _dialogos[0].derechaSantidad;

            _saludSigno = _dialogos[0].derechaSalud > 0
                ? '+'
                : _dialogos[0].derechaSalud < 0
                    ? '-'
                    : '';
            _reputacionSigno = _dialogos[0].derechaReputacion > 0
                ? '+'
                : _dialogos[0].derechaReputacion < 0
                    ? '-'
                    : '';
            _dineroSigno = _dialogos[0].derechaDinero > 0
                ? '+'
                : _dialogos[0].derechaDinero < 0
                    ? '-'
                    : '';
            _santidadSigno = _dialogos[0].derechaSantidad > 0
                ? '+'
                : _dialogos[0].derechaSantidad < 0
                    ? '-'
                    : '';
          }

          if (orientation == CardSwipeOrientation.LEFT ||
              orientation == CardSwipeOrientation.RIGHT) {
            _hideColorStatus();

            _dialogos.removeAt(0);
            //_dialogos.removeAt(0);
          }

          setState(() {});
        },
      ),
    );
  }

  _hideColorStatus() {
    var duration = new Duration(seconds: 1);
    return new Timer(duration, _hideColorStatusAux);
  }

  void _hideColorStatusAux() {
    _saludSigno = '';
    _reputacionSigno = '';
    _dineroSigno = '';
    _santidadSigno = '';
    setState(() {});
  }

  // void _appendImages10() {
  //   if (_currentCard != 0) {
  //     _uiltimoItem = _currentCard;
  //   }
  //   List<String> _aux = new List();
  //   for (var i = 0; i < _cardNum; i++) {
  //     _uiltimoItem++;
  //     _aux.add('https://picsum.photos/500/300/?image=$_uiltimoItem');
  //     _aux.add(
  //         'https://static.wikia.nocookie.net/leagueoflegends/images/1/10/Towa_profileicon.png/revision/latest/top-crop/width/220/height/220?cb=20190827203050');
  //   }
  //   setState(() {
  //     _images = _aux;
  //   });
  // }

  Widget _answer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        color: _direction != 'None' ? Colors.lightBlueAccent : Colors.white,
        child: TextField(
          enabled: false,
          //autofocus: false,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText:
                '${_dialogos.length > 0 && _direction == "Left" ? _dialogos[0].izquierdaDialogo : _dialogos.length > 0 && _direction == "Rigth" ? _dialogos[0].derechaDialogo : "Desliza para ver las opciones."}',
          ),
          onChanged: (valor) {},
        ),
      ),
    );
  }

  Widget _question() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: SizedBox(
          child: _dialogos.isEmpty ? Text("") : _animation(),
        )
        // child: TextField(
        //   enabled: false,
        //   //autofocus: false,
        //   textCapitalization: TextCapitalization.sentences,
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //     hintText:
        //         '${_dialogos[0].dialogo : "Aquí aparecerá la pregunta."}',
        //   ),
        //   onChanged: (valor) {},
        // ),
        );
  }

  Widget _status() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.healing,
              size: MediaQuery.of(context).size.width * 0.08,
              color: _saludStatus
                  ? Colors.grey
                  : _saludSigno == '+'
                      ? Colors.green
                      : _saludSigno == '-'
                          ? Colors.red
                          : Colors.white,
            ),
            Text(
              '${_salud.round()}%',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white),
            ),
            Icon(
              Icons.power,
              size: MediaQuery.of(context).size.width * 0.08,
              color: _reputacionStatus
                  ? Colors.grey
                  : _reputacionSigno == '+'
                      ? Colors.green
                      : _reputacionSigno == '-'
                          ? Colors.red
                          : Colors.white,
            ),
            Text('${_reputacion.round()}%',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white,
                )),
            Icon(
              Icons.monetization_on,
              size: MediaQuery.of(context).size.width * 0.08,
              color: _dineroStatus
                  ? Colors.grey
                  : _dineroSigno == '+'
                      ? Colors.green
                      : _dineroSigno == '-'
                          ? Colors.red
                          : Colors.white,
            ),
            Text('${_dinero.round()}%',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white,
                )),
            Icon(
              Icons.house,
              size: MediaQuery.of(context).size.width * 0.08,
              color: _santidadStatus
                  ? Colors.grey
                  : _santidadSigno == '+'
                      ? Colors.green
                      : _santidadSigno == '-'
                          ? Colors.red
                          : Colors.white,
            ),
            Text('${_santidad.round()}%',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return FloatingActionButton(
      mini: true,
      child: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MenuPage()));
      },
    );
  }

  Widget _animation() {
    return Container(
      // color: Colors.blue,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(  
          child: AutoSizeText(
            '${_dialogos[0].dialogo}',
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
}
