import 'package:flutter/material.dart';
//Pages
import 'package:ockams_razor/src/pages/init_animations.dart';
import 'package:ockams_razor/src/pages/menu.dart';
import 'package:ockams_razor/src/pages/info_game.dart';
import 'package:ockams_razor/src/pages/game.dart';
import 'package:ockams_razor/src/pages/animation.dart';
import 'package:ockams_razor/src/pages/error.dart';
import 'package:ockams_razor/src/pages/death.dart';
import 'package:ockams_razor/src/pages/winGame.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => InitAnimations(),
    'menu': (BuildContext context) => MenuPage(),
    'info': (BuildContext context) => InfoGame(),
    'game': (BuildContext context) => Game(),
    'animation': (BuildContext context) => AnimationInit(),
    'error': (BuildContext context) => ErrorPage(),
    'death': (BuildContext context) => DeathPage(),
    'win': (BuildContext context) => WinPage(),
  };
}
