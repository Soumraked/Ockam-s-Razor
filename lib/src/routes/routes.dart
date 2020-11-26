import 'package:flutter/material.dart';

//Pages
import 'package:ockams_razor/src/pages/init_animations.dart';
import 'package:ockams_razor/src/pages/menu.dart';
import 'package:ockams_razor/src/pages/info_game.dart';
import 'package:ockams_razor/src/pages/game.dart';
import 'package:ockams_razor/src/pages/error.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => InitAnimations(),
    'menu': (BuildContext context) => MenuPage(),
    'info': (BuildContext context) => InfoGame(),
    'game': (BuildContext context) => Game(),
    'error': (BuildContext context) => ErrorPage(),
  };
}
