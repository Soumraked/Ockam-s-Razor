import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class _CargaDialogos {
  List<dynamic> opciones = [];

  _CargaDialogos() {
    cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    final resp = await rootBundle.loadString('data/example.json');

    Map dataMap = json.decode(resp);
    print(dataMap['historia']);
    //opciones = dataMap['rutas'];

    return opciones;
  }
}

final cargaDialogos = new _CargaDialogos();
