import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'package:ockams_razor/src/utils/utils.dart';

import 'package:ockams_razor/src/providers/dialogs.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

//Clase encargada de mostrar el juego en sí, se presentan los dialogos y las respuestas,
// se debe mover a la derecha o izquierda la tarjeta para seleccionar una opción, si las estadísticas
// bajan de 0 o suben de 100 se redigirá a la pantalla correspondiente, al ganr el juego, se
// realizará lo mismo pero con la pantalla de victoria
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
  double _salud = 50;
  double _carisma = 50;
  double _dinero = 50;
  double _suerte = 50;
  bool _saludStatus = false;
  bool _carismaStatus = false;
  bool _dineroStatus = false;
  bool _suerteStatus = false;
  String _saludSigno = '';
  String _carismaSigno = '';
  String _dineroSigno = '';
  String _suerteSigno = '';
  List<Dialogo> _dialogos = new List();
  List<Dialogo> _dialogo = new List();
  List<String> _partes = ['parte1', 'win'];
  String _parte;

  var random = new Random();
  int _randomDeath;
  int _limit = 100000;
  String _message = 'Desliza para ver las opciones.';

  //Lectura de la memoria del dispositivo, se identifica el dialogó donde quedó la partida y se
  // comienzan a escribir en pantallas solo dialgos posteriores
  @override
  void initState() {
    getPrefsString('section').then((v) {
      _parte = v.split(';')[0] == '' ? 'parte1' : v.split(';')[0];
      String _section = v.split(';')[0] == '' ? 'parte1' : v.split(';')[0];
      String _key = v.split(';')[1] == '' ? '1' : v.split(';')[1];
      CargaDialogos(_section, _key).cargarData(_section, _key).then((value) {
        setState(() {
          _dialogos = value;
          _dialogo.add(value[0]);
          _dialogo.add(dialogoFondo);
          _dialogo.add(dialogoFondo);
          // _dialogo.add(dialogoCarga);
          _dialogos.removeAt(0);
        });
      });
    });
    // Se obtiene el valor de las estadisticas guardadas en memoria
    getPrefsInt('_salud').then((value) {
      _salud = value == 0 ? 50.0 : value.toDouble();
    });
    getPrefsInt('_carisma').then((value) {
      _carisma = value == 0 ? 50.0 : value.toDouble();
    });
    getPrefsInt('_dinero').then((value) {
      _dinero = value == 0 ? 50.0 : value.toDouble();
    });
    getPrefsInt('_suerte').then((value) {
      _suerte = value == 0 ? 50.0 : value.toDouble();
    });
    //Se define un número aleatorio de muerte (mata al personaje aleatoriamente con la probabilidad de 1 en 100000)
    _randomDeath = random.nextInt(_limit);
    super.initState();
  }

  //Se guarda en memoria las estadisticas y el avance de la historia, este método se ejecuta automaticamente al dejar la pantalla
  @override
  void dispose() {
    setPrefsBool('partida', true);
    setPrefsString('section', 'parte1;${_dialogo[0].key}');
    setPrefsInt('_salud', _salud.toInt());
    setPrefsInt('_carisma', _carisma.toInt());
    setPrefsInt('_dinero', _dinero.toInt());
    setPrefsInt('_suerte', _suerte.toInt());
    super.dispose();
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

//Widget encargado dl manejo de las cartas de dialgos, estas se montan en el widget TinderSwapCard y
// se configuran sus caracteristicas internas como:
//    - swipeUpdateCallback: método que indica si se tiene seleccionada la tarjeta y en que dirección, esto
//       utiliza para pintar las posibles respuestas de ambos lados en la pantalla, además, de colorear las
//       estadísticas que se verán afectadas con las desiciones
//    - swipeCompleteCallback: método que se ejcuta la mover la carta ala izquierda o derecha, en este
//      se actualizan las estadísticas y se piden los siguientes dialogos, si alguna estadisticas esta fuera
//      de los límites fijados se realiza la redirección a la muerte del personaje, si se llega al final de la
//      historia se procede a redirigir a la pantalla de victoria
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
            if (_dialogo[0].izquierdaCarisma != 0.0) {
              _carismaStatus = true;
            }
            if (_dialogo[0].izquierdaDinero != 0.0) {
              _dineroStatus = true;
            }
            if (_dialogo[0].izquierdaSuerte != 0.0) {
              _suerteStatus = true;
            }
          } else if (align.x > 0) {
            //Card is RIGHT swiping
            _direction = 'Rigth';
            if (_dialogo[0].derechaSalud != 0.0) {
              _saludStatus = true;
            }
            if (_dialogo[0].derechaCarisma != 0.0) {
              _carismaStatus = true;
            }
            if (_dialogo[0].derechaDinero != 0.0) {
              _dineroStatus = true;
            }
            if (_dialogo[0].derechaSuerte != 0.0) {
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

          if (orientation == CardSwipeOrientation.LEFT) {
            _salud += _dialogo[0].izquierdaSalud;
            _carisma += _dialogo[0].izquierdaCarisma;
            _dinero += _dialogo[0].izquierdaDinero;
            _suerte += _dialogo[0].izquierdaSuerte;

            _saludSigno = _dialogo[0].izquierdaSalud > 0
                ? '+'
                : _dialogo[0].izquierdaSalud < 0
                    ? '-'
                    : '';
            _carismaSigno = _dialogo[0].izquierdaCarisma > 0
                ? '+'
                : _dialogo[0].izquierdaCarisma < 0
                    ? '-'
                    : '';
            _dineroSigno = _dialogo[0].izquierdaDinero > 0
                ? '+'
                : _dialogo[0].izquierdaDinero < 0
                    ? '-'
                    : '';
            _suerteSigno = _dialogo[0].izquierdaSuerte > 0
                ? '+'
                : _dialogo[0].izquierdaSuerte < 0
                    ? '-'
                    : '';
          }

          if (orientation == CardSwipeOrientation.RIGHT) {
            _salud += _dialogo[0].derechaSalud;
            _carisma += _dialogo[0].derechaCarisma;
            _dinero += _dialogo[0].derechaDinero;
            _suerte += _dialogo[0].derechaSuerte;

            _saludSigno = _dialogo[0].derechaSalud > 0
                ? '+'
                : _dialogo[0].derechaSalud < 0
                    ? '-'
                    : '';
            _carismaSigno = _dialogo[0].derechaCarisma > 0
                ? '+'
                : _dialogo[0].derechaCarisma < 0
                    ? '-'
                    : '';
            _dineroSigno = _dialogo[0].derechaDinero > 0
                ? '+'
                : _dialogo[0].derechaDinero < 0
                    ? '-'
                    : '';
            _suerteSigno = _dialogo[0].derechaSuerte > 0
                ? '+'
                : _dialogo[0].derechaSuerte < 0
                    ? '-'
                    : '';
          }

          if (_salud <= 0) {
            _redirectDeath('menorSalud');
          } else if (_carisma.toInt() <= 0) {
            _redirectDeath('menorCarisma');
          } else if (_dinero.toInt() <= 0) {
            _redirectDeath('menorDinero');
          } else if (_suerte.toInt() <= 0) {
            _redirectDeath('menorSuerte');
          } else if (_salud.toInt() >= 100) {
            _redirectDeath('mayorSalud');
          } else if (_carisma.toInt() >= 100) {
            _redirectDeath('mayorCarisma');
          } else if (_dinero.toInt() >= 100) {
            _redirectDeath('mayorDinero');
          } else if (_suerte.toInt() >= 100) {
            _redirectDeath('mayorSuerte');
          } else if (_randomDeath == random.nextInt(_limit)) {
            _redirectDeath('random');
          }

          if (orientation == CardSwipeOrientation.LEFT ||
              orientation == CardSwipeOrientation.RIGHT) {
            _hideColorStatus();

            _dialogo.removeAt(0);
            _dialogo.removeAt(0);
            timeTransition();
            if (_dialogos.length == 0) {}
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

//Solicitud de los siguientes dialogos
  transition() {
    if (_dialogos.isEmpty) {
      rellenarDialogos();
    } else {
      _dialogo.insert(0, dialogoFondo);
      _dialogo.insert(0, _dialogos[0]);
      _dialogos.removeAt(0);
    }
    setState(() {});
  }

//Solicitud de la siguiente parte de la historia o la victoria si corresponde
  rellenarDialogos() {
    _parte = _partes[_partes.indexOf(_parte) + 1];
    if (_parte == 'win') {
      Navigator.pushNamed(context, 'win');
    } else {
      _dialogo = new List();
      CargaDialogos(_parte, '1').cargarData(_parte, '1').then((value) {
        _dialogos = value;
        _dialogo.add(value[0]);
        _dialogo.add(dialogoFondo);
        _dialogo.add(dialogoFondo);
        _dialogos.removeAt(0);
        setState(() {});
      });
    }
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

//Respuesta de la izquierda o derecha segpun la direccion en que se mueva la carta
  Widget _answer() {
    return Container(
      // color: Colors.blue,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: AutoSizeText(
            '${_dialogo.length > 0 && _direction == 'Left' ? _dialogo[0].izquierdaDialogo : _dialogo.length > 0 && _direction == 'Rigth' ? _dialogo[0].derechaDialogo : _message}',
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

//Texto del dialogo
  Widget _question() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      child: _dialogo.isEmpty ? Text('') : _animation(),
    );
  }

//Barra de estados
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

//Barra de estados, simbolo más numero
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

  Widget _backButton() {
    setPrefsBool('partida', true);
    setPrefsString('section', 'parte1;${_dialogo[0].key}');
    setPrefsInt('_salud', _salud.toInt());
    setPrefsInt('_carisma', _carisma.toInt());
    setPrefsInt('_dinero', _dinero.toInt());
    setPrefsInt('_suerte', _suerte.toInt());
    return FloatingActionButton(
      mini: true,
      child: Icon(Icons.arrow_back),
      backgroundColor: Color.fromARGB(221, 160, 54, 20),
      onPressed: () {
        Navigator.pushNamed(context, '/');
      },
    );
  }

//Redimensión del dialogo de la pantalla a través de la libreria AutoSizeText
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

//Redirección en caso de muerte del personaje
  void _redirectDeath(String message) {
    _salud = 50;
    _carisma = 50;
    _dinero = 50;
    _suerte = 50;
    Navigator.pushNamed(context, 'death', arguments: message);
  }
}
