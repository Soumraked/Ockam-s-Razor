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
  double _carisma = 50;
  double _dinero = 50;
  double _suerte = 50;
  bool _saludStatus = false;
  bool _carismaStatus = false;
  bool _dineroStatus = false;
  bool _suerteStatus = false;
  String _saludSigno = "";
  String _carismaSigno = "";
  String _dineroSigno = "";
  String _suerteSigno = "";
  List<Dialogo> _dialogos = new List();
  List<Dialogo> _dialogo = new List();

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
        _dialogo.add(value[0]);
        _dialogo.add(dialogoFondo);
        _dialogo.add(dialogoFondo);
        // _dialogo.add(dialogoCarga);
        _dialogos.removeAt(0);
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
                AbsorbPointer(
                  absorbing: _dialogo.length <= 2,
                  child: _tinderSwipe(),
                ),
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
      height: MediaQuery.of(context).size.height * 0.4,
      child: new TinderSwapCard(
        swipeUp: false,
        swipeDown: false,
        orientation: AmassOrientation.BOTTOM,
        totalNum: _dialogo.length,
        stackNum: 2,
        swipeEdge: 7.0,
        animDuration: 0,
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
                image: AssetImage(_dialogo[index].imagen),
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
            if (_dialogo[0].izquierdaSalud != 0.0) {
              _saludStatus = true;
            }
            if (_dialogo[0].izquierdaReputacion != 0.0) {
              _carismaStatus = true;
            }
            if (_dialogo[0].izquierdaDinero != 0.0) {
              _dineroStatus = true;
            }
            if (_dialogo[0].izquierdaSantidad != 0.0) {
              _suerteStatus = true;
            }
          } else if (align.x > 0) {
            //Card is RIGHT swiping
            _direction = 'Rigth';
            if (_dialogo[0].derechaSalud != 0.0) {
              _saludStatus = true;
            }
            if (_dialogo[0].derechaReputacion != 0.0) {
              _carismaStatus = true;
            }
            if (_dialogo[0].derechaDinero != 0.0) {
              _dineroStatus = true;
            }
            if (_dialogo[0].derechaSantidad != 0.0) {
              _suerteStatus = true;
            }
          } else {
            _direction = 'None';

            _saludStatus = false;
            _carismaStatus = false;
            _dineroStatus = false;
            _suerteStatus = false;
          }
          _saludSigno = '';
          _carismaSigno = '';
          _dineroSigno = '';
          _suerteSigno = '';
          setState(() {});
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          /// Get orientation & index of swiped card!
          _direction = 'None';
          _saludStatus = false;
          _carismaStatus = false;
          _dineroStatus = false;
          _suerteStatus = false;

          print(_saludStatus);
          print(_carismaStatus);
          print(_dineroStatus);
          print(_suerteStatus);

          if (orientation == CardSwipeOrientation.LEFT) {
            _salud += _dialogo[0].izquierdaSalud;
            _carisma += _dialogo[0].izquierdaReputacion;
            _dinero += _dialogo[0].izquierdaDinero;
            _suerte += _dialogo[0].izquierdaSantidad;

            _saludSigno = _dialogo[0].izquierdaSalud > 0
                ? '+'
                : _dialogo[0].izquierdaSalud < 0
                    ? '-'
                    : '';
            _carismaSigno = _dialogo[0].izquierdaReputacion > 0
                ? '+'
                : _dialogo[0].izquierdaReputacion < 0
                    ? '-'
                    : '';
            _dineroSigno = _dialogo[0].izquierdaDinero > 0
                ? '+'
                : _dialogo[0].izquierdaDinero < 0
                    ? '-'
                    : '';
            _suerteSigno = _dialogo[0].izquierdaSantidad > 0
                ? '+'
                : _dialogo[0].izquierdaSantidad < 0
                    ? '-'
                    : '';
          }

          if (orientation == CardSwipeOrientation.RIGHT) {
            _salud += _dialogo[0].derechaSalud;
            _carisma += _dialogo[0].derechaReputacion;
            _dinero += _dialogo[0].derechaDinero;
            _suerte += _dialogo[0].derechaSantidad;

            _saludSigno = _dialogo[0].derechaSalud > 0
                ? '+'
                : _dialogo[0].derechaSalud < 0
                    ? '-'
                    : '';
            _carismaSigno = _dialogo[0].derechaReputacion > 0
                ? '+'
                : _dialogo[0].derechaReputacion < 0
                    ? '-'
                    : '';
            _dineroSigno = _dialogo[0].derechaDinero > 0
                ? '+'
                : _dialogo[0].derechaDinero < 0
                    ? '-'
                    : '';
            _suerteSigno = _dialogo[0].derechaSantidad > 0
                ? '+'
                : _dialogo[0].derechaSantidad < 0
                    ? '-'
                    : '';
          }

          if (orientation == CardSwipeOrientation.LEFT ||
              orientation == CardSwipeOrientation.RIGHT) {
            _hideColorStatus();

            _dialogo.removeAt(0);
            _dialogo.removeAt(0);
            timeTransition();
            //_dialogos.removeAt(0);
          }

          setState(() {});
        },
      ),
    );
  }

  timeTransition() async {
    var duration = new Duration(milliseconds: 100);
    return new Timer(duration, transition);
  }

  transition() {
    if (_dialogos.isEmpty) {
      _dialogos.removeAt(0);
      rellenarDialogos();
    } else {
      _dialogo.insert(0, dialogoFondo);
      _dialogo.insert(0, _dialogos[0]);
      _dialogos.removeAt(0);
    }
    setState(() {});
  }

  rellenarDialogos() async {
    cargaDialogos.cargarData().then((value) {
      _dialogos = value;
      _dialogo.add(value[0]);
      _dialogo.add(dialogoFondo);
      _dialogos.removeAt(0);
      setState(() {});
    });
  }

  _hideColorStatus() {
    var duration = new Duration(seconds: 1);
    return new Timer(duration, _hideColorStatusAux);
  }

  void _hideColorStatusAux() {
    _saludSigno = '';
    _carismaSigno = '';
    _dineroSigno = '';
    _suerteSigno = '';
    setState(() {});
  }

  Widget _answer() {
    return Container(
      // color: Colors.blue,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: AutoSizeText(
            '${_dialogo.length > 0 && _direction == "Left" ? _dialogo[0].izquierdaDialogo : _dialogo.length > 0 && _direction == "Rigth" ? _dialogo[0].derechaDialogo : "Desliza para ver las opciones."}',
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

  Widget _question() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: _dialogo.isEmpty ? Text("") : _animation(),
    );
  }

  Widget _status() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        // color: Colors.blue,
        // child: _statusNormal(),
        child: _grid(),
      ),
    );
  }

  Widget _grid() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Center(
        child: GridView.count(
          childAspectRatio: 4,
          crossAxisCount: 4,
          children: [
            Text(
              '${_salud.round()}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                color: _saludStatus
                    ? Colors.grey
                    : _saludSigno == '+'
                        ? Colors.green
                        : _saludSigno == '-'
                            ? Colors.red
                            : Colors.white,
              ),
            ),
            Text('${_carisma.round()}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: _carismaStatus
                      ? Colors.grey
                      : _carismaSigno == '+'
                          ? Colors.green
                          : _carismaSigno == '-'
                              ? Colors.red
                              : Colors.white,
                )),
            Text('${_dinero.round()}%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: _dineroStatus
                      ? Colors.grey
                      : _dineroSigno == '+'
                          ? Colors.green
                          : _dineroSigno == '-'
                              ? Colors.red
                              : Colors.white,
                )),
            Text(
              '${_suerte.round()}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                color: _suerteStatus
                    ? Colors.grey
                    : _suerteSigno == '+'
                        ? Colors.green
                        : _suerteSigno == '-'
                            ? Colors.red
                            : Colors.white,
              ),
            ),
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
            Icon(
              Icons.child_care,
              size: MediaQuery.of(context).size.width * 0.08,
              color: _carismaStatus
                  ? Colors.grey
                  : _carismaSigno == '+'
                      ? Colors.green
                      : _carismaSigno == '-'
                          ? Colors.red
                          : Colors.white,
            ),
            Icon(
              Icons.monetization_on_outlined,
              size: MediaQuery.of(context).size.width * 0.08,
              color: _dineroStatus
                  ? Colors.grey
                  : _dineroSigno == '+'
                      ? Colors.green
                      : _dineroSigno == '-'
                          ? Colors.red
                          : Colors.white,
            ),
            Icon(
              Icons.auto_awesome,
              size: MediaQuery.of(context).size.width * 0.08,
              color: _suerteStatus
                  ? Colors.grey
                  : _suerteSigno == '+'
                      ? Colors.green
                      : _suerteSigno == '-'
                          ? Colors.red
                          : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusNormal() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_salud.round()}%',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white),
              ),
              Text('${_carisma.round()}%',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                  )),
              Text('${_dinero.round()}%',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.white,
                  )),
              Text(
                '${_suerte.round()}%',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
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
              Icon(
                Icons.child_care,
                size: MediaQuery.of(context).size.width * 0.08,
                color: _carismaStatus
                    ? Colors.grey
                    : _carismaSigno == '+'
                        ? Colors.green
                        : _carismaSigno == '-'
                            ? Colors.red
                            : Colors.white,
              ),
              Icon(
                Icons.monetization_on_outlined,
                size: MediaQuery.of(context).size.width * 0.08,
                color: _dineroStatus
                    ? Colors.grey
                    : _dineroSigno == '+'
                        ? Colors.green
                        : _dineroSigno == '-'
                            ? Colors.red
                            : Colors.white,
              ),
              Icon(
                Icons.auto_awesome,
                size: MediaQuery.of(context).size.width * 0.08,
                color: _suerteStatus
                    ? Colors.grey
                    : _suerteSigno == '+'
                        ? Colors.green
                        : _suerteSigno == '-'
                            ? Colors.red
                            : Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _backButton() {
    return FloatingActionButton(
      mini: true,
      child: Icon(Icons.arrow_back),
      backgroundColor: Color.fromARGB(221, 160, 54, 20),
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
            '${_dialogo[0].dialogo}',
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
