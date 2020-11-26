import 'package:flutter/material.dart';

import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ockams_razor/src/pages/menu.dart';

import 'package:ockams_razor/src/utils/utils.dart';

import 'package:ockams_razor/src/providers/dialogs.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<String> _images = new List();
  int _uiltimoItem = 0;
  int _cardNum = 3;
  CardController _controllerCard = new CardController();
  String _direction = 'None';
  int _currentCard = 0;
  int _salud = 99;
  int _reputacion = 99;
  int _dinero = 99;
  int _santidad = 99;

  @override
  void initState() {
    super.initState();

    getPrefsInt('CurrentCard').then((value) {
      _currentCard = value;
      _appendImages10();
    });

    cargaDialogos.cargarData().then((value) {
      print(value);
    });

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    setPrefsInt('CurrentCard', _currentCard);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Carta actual número: $_currentCard'),
                Divider(),
                _status(),
                _question(),
                _tinderSwipe(),
                _leftAnswer(),
                _rigthAnswer()
              ],
            ),
            // child: Container(
            //   child: _tinderSwipe(),
            // ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MenuPage()));
            },
          ),
        ),
      ),
    );
  }

  Widget _tinderSwipe() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: new TinderSwapCard(
        swipeUp: true,
        swipeDown: true,
        orientation: AmassOrientation.BOTTOM,
        totalNum: _images.length,
        stackNum: 4,
        swipeEdge: 6.0,
        animDuration: 300,
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        maxHeight: MediaQuery.of(context).size.width * 0.9,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        minHeight: MediaQuery.of(context).size.width * 0.8,
        cardBuilder: (context, index) => Card(
          child: FadeInImage(
            image: NetworkImage(_images[index]),
            placeholder: AssetImage('assets/jar-loading.gif'),
            // fadeInDuration: Duration(milliseconds: 200),
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        cardController: _controllerCard,
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            //Card is LEFT swiping
            _direction = 'Left';
          } else if (align.x > 0) {
            //Card is RIGHT swiping
            _direction = 'Rigth';
          } else {
            _direction = 'None';
          }
          setState(() {});
        },
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          /// Get orientation & index of swiped card!
          _direction = 'None';
          print(index);
          print(_images.length);
          if (orientation != CardSwipeOrientation.RECOVER) {
            _currentCard++;
          }

          if (orientation == CardSwipeOrientation.LEFT) {
            _salud--;
            _reputacion--;
            _dinero--;
            _santidad--;
          }

          if (orientation == CardSwipeOrientation.RIGHT) {
            _salud++;
            _reputacion++;
            _dinero++;
            _santidad++;
          }

          if (orientation == CardSwipeOrientation.LEFT ||
              orientation == CardSwipeOrientation.RIGHT) {
            _images.removeAt(0);
            _images.removeAt(0);
          }

          if ((_images.length == 0 || _images.length == 1) &&
              orientation != CardSwipeOrientation.RECOVER) {
            _appendImages10();
          }

          setState(() {});
        },
      ),
    );
  }

  void _appendImages10() {
    if (_currentCard != 0) {
      _uiltimoItem = _currentCard;
    }
    List<String> _aux = new List();
    for (var i = 0; i < _cardNum; i++) {
      _uiltimoItem++;
      _aux.add('https://picsum.photos/500/300/?image=$_uiltimoItem');
      _aux.add(
          'https://static.wikia.nocookie.net/leagueoflegends/images/1/10/Towa_profileicon.png/revision/latest/top-crop/width/220/height/220?cb=20190827203050');
    }
    setState(() {
      _images = _aux;
    });
  }

  Widget _leftAnswer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        color: _direction == 'Left' ? Colors.lightBlueAccent : Colors.white,
        child: TextField(
          enabled: false,
          //autofocus: false,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Respuesta izquierda',
              icon: Icon(Icons.arrow_back_ios)),
          onChanged: (valor) {},
        ),
      ),
    );
  }

  Widget _rigthAnswer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        color: _direction == 'Rigth' ? Colors.lightBlueAccent : Colors.white,
        child: TextField(
          enabled: false,
          //autofocus: false,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: 'Respuesta derecha',
              icon: Icon(Icons.arrow_forward_ios)),
          onChanged: (valor) {},
        ),
      ),
    );
  }

  Widget _question() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        enabled: false,
        //autofocus: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: 'Pregunta',
            icon: Icon(Icons.question_answer)),
        onChanged: (valor) {},
      ),
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
            ),
            Text('$_salud%',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05)),
            Icon(
              Icons.power,
              size: MediaQuery.of(context).size.width * 0.08,
            ),
            Text('$_reputacion%',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05)),
            Icon(
              Icons.monetization_on,
              size: MediaQuery.of(context).size.width * 0.08,
            ),
            Text('$_dinero%',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05)),
            Icon(
              Icons.house,
              size: MediaQuery.of(context).size.width * 0.08,
            ),
            Text('$_santidad%',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05)),
          ],
        ),
      ),
    );
  }
}
